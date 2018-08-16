resource "aws_ecs_service" "service" {
  name                               = "${var.name_prefix}"
  cluster                            = "${aws_ecs_cluster.cluster.id}"
  task_definition                    = "${aws_ecs_task_definition.task.arn}"
  desired_count                      = "${var.desired_count}"
  launch_type                        = "FARGATE"
  deployment_minimum_healthy_percent = "${var.minimum_healthy_percent}"
  deployment_maximum_percent         = "${var.maximum_healthy_percent}"
  health_check_grace_period_seconds  = "${var.health_check_grace_period_seconds}"

  network_configuration {
    subnets          = ["${module.vpc.private_subnets}"]
    security_groups  = ["${aws_security_group.ecs_service_sg.id}"]
    assign_public_ip = "${var.task_container_assign_public_ip}"
  }

  load_balancer {
    container_name   = "${var.name_prefix}"
    container_port   = "${var.task_container_port}"
    target_group_arn = "${module.target_group_task.arn}"
  }
}

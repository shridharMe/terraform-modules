

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.name_prefix}"
  execution_role_arn       = "${aws_iam_role.execution.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.task_definition_cpu}"
  memory                   = "${var.task_definition_memory}"
  task_role_arn            = "${aws_iam_role.task.arn}"
  container_definitions    = "${var.container_definitions}
}

data "aws_region" "current" {}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.name_prefix}"
  execution_role_arn       = "${aws_iam_role.execution.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.task_definition_cpu}"
  memory                   = "${var.task_definition_memory}"
  task_role_arn            = "${aws_iam_role.task.arn}"

  container_definitions = <<EOF
[{
     "cpu": ${var.task_definition_cpu},
      "image": "${var.image}:${var.image_version}",
      "memory": ${var.task_definition_memory},
      "name": "${var.environment}-${var.name_prefix}",    
      "networkMode": "awsvpc",
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.name}",
            "awslogs-region": "${aws_region.current.name}",
            "awslogs-stream-prefix": "ecs"
          }
      },    
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.host_port}
        }
      ]
}]
EOF
}

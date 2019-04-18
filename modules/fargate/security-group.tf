resource "aws_security_group" "ecs_service_sg" {
  description = "controls access to elb"
  vpc_id      = "${module.vpc.vpc_id}"
  name        = "${var.name_prefix}-ecs-service-sg"

  ingress {
    protocol        = "tcp"
    from_port       = "${var.task_container_port}"
    to_port         = "${var.task_container_port}"
    security_groups = ["${aws_security_group.alb-sg.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags {
    Name        = "${var.name_prefix}"
    Environment = "${var.environment}"
    Terraform   = "${var.terraform}"
    Owner       = "${var.owner}"
  }
}

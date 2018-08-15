resource "aws_security_group" "ecs_service_sg" {
  description = "controls access to elb"
  vpc_id      = "${var.vpc_id}"
  name        = "${var.name_prefix}-ecs-service-sg"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = "${var.tags}"
}
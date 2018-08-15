# Create a new load balancer
resource "aws_security_group" "alb-sg" {
  description = "controls access to elb"
  vpc_id      = "${var.vpc_id}"
  name        = "${var.name_prefix}-alb-sg"

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["${var.source_cidr_block_inbound}"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}

module "target_group_task" {
  source            = "../alb/target-group"
  name              = "${var.name_prefix}-target-group"
  vpc_id            = "${vars.vpc_id}"
  health_check_path = "${var.alb-health_check_path}"
}

module "listener" {
  source                   = "../alb/listener/https"
  alb_arn                  = "${aws_alb.alb.arn}"
  ssl_policy               = "${var.ssl_policy}"
  certificate_arn          = "${var.certificate_arn}"
  default_target_group_arn = "${module.target_group_task.arn}"
}

module "listener-rule" {
  source           = "../alb/listener-rule/path"
  listener_arn     = "${module.listener.arn}"
  priority         = "${var.priority}"
  path_pattern     = "${var.path_pattern}"
  target_group_arn = "${module.target_group_task.arn}"
}

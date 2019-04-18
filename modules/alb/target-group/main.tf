resource "aws_alb_target_group" "target_group" {
  name        = "${var.name}"
  port        = "${var.port}"
  protocol    = "${var.protocol}"
  vpc_id      = "${var.vpc_id}"
  tags        = "${var.tags}"
  target_type = "${var.target_type}"

  deregistration_delay = "${var.deregistration_delay}"

  stickiness {
    type            = "${var.stickiness_type}"
    cookie_duration = "${var.stickiness_cookie_duration}"
    enabled         = "${var.stickiness_enabled}"
  }

  health_check {
    path    = "${var.health_check_path}"
    matcher = "${var.health_check_matcher}"
  }
}

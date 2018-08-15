resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "${var.ssl_policy}"
  certificate_arn   = "${var.certificate_arn}"

  default_action {
    target_group_arn = "${var.default_target_group_arn}"
    type             = "forward"
  }
}

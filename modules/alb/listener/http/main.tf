resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${var.default_target_group_arn}"
    type             = "forward"
  }
}

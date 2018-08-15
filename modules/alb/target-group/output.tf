output "id" {
  value = "${aws_alb_target_group.target_group.id}"
}

output "arn" {
  value = "${aws_alb_target_group.target_group.arn}"
}

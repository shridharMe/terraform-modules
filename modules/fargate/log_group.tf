resource "aws_cloudwatch_log_group" "main" {
  name              = "${var.name_prefix}"
  retention_in_days = "${var.log_retention_in_days}"
  tags              = "${var.tags}"
}

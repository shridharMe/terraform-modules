

output "node-security-id" {
  value = "${aws_security_group.node.id}"
}

output "node-role-arn" {
  value = "${aws_iam_role.node.arn}"
}


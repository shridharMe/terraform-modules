output "ids" {
  value       = aws_security_group.sg_for_lambda.id
  description = "The arn for SG id"
}


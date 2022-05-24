output "iam_role_arn" {
  value       = aws_iam_role.iam_for_lambda.arn
  description = "The arn for lambda role"
}



resource "aws_lambda_function" "test" {
  function_name    = var.lambda_function_name
  role             = var.lambda_role_arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  filename         = var.lambda_filename
  source_code_hash = var.lambda_source_code_hash
  vpc_config {
    subnet_ids         = var.private_subnets_ids
    security_group_ids = var.security_group_ids
  }
}



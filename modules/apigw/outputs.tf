output "base_url" {
  description = "Base URL for API Gateway stage."
  value       = aws_apigatewayv2_stage.lambda.invoke_url
}

output "lambda_name" {
  value = aws_apigatewayv2_api.lambda.name
}

output "lambda_id" {
  value = aws_apigatewayv2_api.lambda.id
}

output "lambda_execution_arn" {
  value = aws_apigatewayv2_api.lambda.execution_arn
}




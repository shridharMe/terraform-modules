resource "aws_apigatewayv2_api" "lambda" {
  name          = var.apigatewayv2_name //"serverless_lambda_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

  name        = "serverless_lambda_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name              = join("/", ["/aws", "api_gw", aws_apigatewayv2_api.lambda.name])
  retention_in_days = 30
}


resource "aws_apigatewayv2_integration" "hello_world" {
  api_id             = aws_apigatewayv2_api.lambda.id
  integration_uri    = var.lambda_invoke_arn
  integration_type   = "HTTP_PROXY"
  integration_method = "POST"
}


resource "aws_apigatewayv2_route" "hello_world" {
  api_id    = aws_apigatewayv2_api.lambda.id
  route_key = var.route_key
  target    = join("/", ["integrations", aws_apigatewayv2_integration.hello_world.id])
}


resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = join("/", [aws_apigatewayv2_api.lambda.execution_arn, "*", "*"])
}




/*
resource "aws_apigatewayv2_integration" "healthchek" {
  api_id             = aws_apigatewayv2_api.lambda.id
  integration_uri    = var.healthchek_lambda_invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}


resource "aws_apigatewayv2_route" "healthchek" {
  api_id    = aws_apigatewayv2_api.lambda.id
  route_key = var.healthchek_route_key
  target    = join("/", ["integrations", aws_apigatewayv2_integration.healthchek.id])
}


resource "aws_lambda_permission" "api_gw_healthchek" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.healthchek_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = join("/", [aws_apigatewayv2_api.lambda.execution_arn, "*", "*"])
}
*/
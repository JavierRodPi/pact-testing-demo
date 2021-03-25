resource "aws_api_gateway_integration" "get_user_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.user_id.id
  http_method             = aws_api_gateway_method.get_user.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.get_user.invoke_arn
  passthrough_behavior   = "WHEN_NO_TEMPLATES"
  request_templates = {
    "application/json" = "{ \"requestContext\": {\"authorizer\": {\"accessToken\": \"token\"}}}"
  }
}

resource "aws_api_gateway_method" "get_user" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.user_id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_lambda_permission" "get_user_lambda_permission" {
  depends_on = [
    aws_api_gateway_method.get_user
  ]
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_user.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:eu-west-1:000000000000:${var.rest_api_id}/*/${aws_api_gateway_method.get_user.http_method}${aws_api_gateway_resource.user_id.path}"
}

resource "aws_api_gateway_method_response" "response_200_get_user" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.user_id.id
  http_method = aws_api_gateway_method.get_user.http_method
  status_code = "200"
}

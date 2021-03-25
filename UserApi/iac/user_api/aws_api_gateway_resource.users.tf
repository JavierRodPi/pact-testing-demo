resource "aws_api_gateway_resource" "users" {
  rest_api_id = aws_api_gateway_rest_api.local_api.id
  parent_id   = aws_api_gateway_rest_api.local_api.root_resource_id
  path_part   = "user"
}

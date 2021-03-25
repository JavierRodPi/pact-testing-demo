resource "aws_api_gateway_resource" "user_id" {
  rest_api_id = var.rest_api_id
  parent_id   = var.users_resource_id
  path_part   = "{userId}"
}



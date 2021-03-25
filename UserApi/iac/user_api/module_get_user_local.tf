module "get_user" {
  source                      = "./modules/get_user"
  rest_api_id                 = aws_api_gateway_rest_api.local_api.id
  common_tags                 = var.common_tags
  artifacts_bucket_name       = var.artifacts_bucket_name
  users_resource_id           = aws_api_gateway_resource.users.id
  salesforce_user_api_url     = ""
}

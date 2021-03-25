module "user_api" {
  source                              = "../../user_api"
  artifacts_bucket_name               = "artifacts"
  api_gateway_stage_name              = "api"
  cloudwatch_role                     = "api_gateway_users_service_cloudwatch_role_dev"
  account_id                          =  "00000000"
  common_tags                         = var.common_tags
}
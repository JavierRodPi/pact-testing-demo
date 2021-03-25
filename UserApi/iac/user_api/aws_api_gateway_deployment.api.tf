resource "time_sleep" "wait_60_seconds_local_api" {
  triggers = {
    timestamp = timestamp()
  }

  create_duration  = "20s"
  destroy_duration = "20s"
}

resource "aws_api_gateway_deployment" "local_api" {
  rest_api_id = aws_api_gateway_rest_api.local_api.id
  stage_name  = var.api_gateway_stage_name
  depends_on  = [time_sleep.wait_60_seconds_local_api]

  # variables = {

  #   trigger_hash = sha1(join(",", [
  #     jsonencode(aws_api_gateway_resource.v1),
  #     jsonencode(aws_api_gateway_resource.internal),
  #     jsonencode(module.get_token.aws_lambda_function_get_token),
  #     jsonencode(module.get_token.aws_api_gateway_resource_token),
  #     jsonencode(module.get_token.aws_api_gateway_method_get_token),
  #     jsonencode(module.verify.aws_api_gateway_resource_verify),
  #     jsonencode(module.verify.aws_api_gateway_method_verify),
  #     jsonencode(aws_api_gateway_resource.users),
  #     jsonencode(module.patch_user.aws_lambda_function_patch_user),
  #     jsonencode(module.patch_user.aws_api_gateway_method_patch_user),
  #     jsonencode(module.users_service_authorizer.aws_lambda_function),
  #     jsonencode(module.user_phone_validation.aws_api_gateway_resource_user_phone_validation),
  #     jsonencode(module.user_phone_validation.aws_api_gateway_method_user_phone_validation),
  #     jsonencode(module.user_phone_validation.aws_api_gateway_method_user_phone_validation_put),
  #     jsonencode(module.user_phone_validation.aws_lambda_function_user_phone_validation),
  #   ]))
  # }

  lifecycle {
    create_before_destroy = true
  }
}

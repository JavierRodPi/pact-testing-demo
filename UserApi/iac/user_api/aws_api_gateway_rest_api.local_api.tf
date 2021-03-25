resource "aws_api_gateway_rest_api" "local_api" {
  name        = "local_api"
  description = "API gateway for mocks"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}
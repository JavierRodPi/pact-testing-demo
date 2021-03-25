variable "artifacts_bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "API Gateway stage name"
  type        = string
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "api_name" {
  type    = string
  default = "Users API"
}

variable "cloudwatch_role" {
  type = string
}

variable "common_tags" {
  description = "This is a map type for applying tags on resources"
  type        = map
}

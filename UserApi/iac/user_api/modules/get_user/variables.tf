variable "rest_api_id" {
  type        = string
  description = "ID for the API Gateway REST API"
}

variable "common_tags" {
  description = "This is a map type for applying tags on resources"
  type        = map
}

variable "artifacts_bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "get_user_bucket_key" {
  type = string
  default = "get-user.zip"
}

variable "users_resource_id" {
  type = string
}

variable "get_user_name" {
  type        = string
  default     = "getUser_UserService"
  description = "name of lambda function"
}

variable "get_user_role" {
  type    = string
  default = "get_user_role"
}

variable "salesforce_user_api_url" {
  type        = string
  description = "URL to get the the information about Salesforce user"
  default = "http://localhost"
}

provider "aws" {
  region                      = "eu-west-1"
  version                     = "~>2.64"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    iam            = "http://localhost:4566"    
    lambda         = "http://localhost:4566"
    s3             = "http://localhost:4566"
  }
}

provider "template" {
  version = "2.1"
}

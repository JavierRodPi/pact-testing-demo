resource "aws_lambda_function" "get_user" {
  function_name = var.get_user_name
  role          = aws_iam_role.get_user_role.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"

  s3_bucket         = var.artifacts_bucket_name
  s3_key            =  var.get_user_bucket_key
  s3_object_version = null

  timeout = 20

  tags = var.common_tags
}

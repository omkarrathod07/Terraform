data "aws_iam_policy_document" "lambda-role" {
  statement {
    effect = "allow"
    principals {
      type = "Service"
      identifiers = [ "lambda.amazonaws.com" ]
    }
    actions = [ "sts:AssumeRole" ]
  }
}
data "archive_file" "nodejs" {
  type = "zip"
  source_file = "${path.module}/lambda/index.js"
  output_path = "${path.module}/lambda/function.zip"
}
//-----------------/\Data/\--------------
resource "aws_iam_role" "lambda-roles" {
  name = "${var.name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-role.json
}
//-----------------/\Role/\--------------
resource "aws_lambda_function" "lambda-demo" {
  filename = data.archive_file.nodejs.output_path
  function_name = "${var.name}-lambda-function"
  role = aws_iam_role.lambda-roles.arn
  handler = "index.handler"
  code_sha256 = data.archive_file.nodejs.output_base64sha256

  runtime = var.runtime

  environment {
    variables = var.environment
  }
  tags = var.tags
}
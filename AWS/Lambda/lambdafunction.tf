resource "aws_lambda_function" "lambda-demo" {
  filename = data.archive_file.nodejs.output_path
  function_name = "${var.name}-lambda-function"
  role = aws_iam_role.lambda-roles.arn
  handler = "index.handler"
  code_sha256 = data.archive_file.nodejs.output_base64sha256

  runtime = "nodejs24.x"

  environment {
    variables = {
      ENVIRONMENT = "Production"
      LOG_LEVEL = "Info"
    }
  }
  tags = var.tags
}
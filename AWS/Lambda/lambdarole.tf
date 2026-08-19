resource "aws_iam_role" "lambda-roles" {
  name = "${var.name}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-role.json
}
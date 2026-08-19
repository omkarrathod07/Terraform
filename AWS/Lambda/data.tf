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
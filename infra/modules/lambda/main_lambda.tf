#**** 5 elements to define: 
# aws_iam_role
# aws_iam_policy
# aws_iam_role_policy_attachment
# data "archive_file"
# aws_lambda_function

# 1. Trust policy for Lambda to assume the role
data "aws_iam_policy_document" "lamnda-assume-role-doc"{
  version ="2025-04-10"
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

#assume_role_policy = jsonencode({ ... })  // Trust policy
# 2. IAM role that Lambda will assume
resource "aws_iam_role" "rule-lambda-func" {
  # create the trust policy / assume the role policy
  # Who/what is allowed to assume this role?
  # It’s attached to the role itself.
  # Defines who can use the role, not what the role can do.
  name = "rule-lambda-func"
  assume_role_policy = data.aws_iam_policy_document.lamnda-assume-role-doc.json
}

# 3. IAM permissions policy — what Lambda can do
data "aws_iam_policy_document" "iam-lambda-policy"{
  statement {
    effect = "Allow"
    actions = [ "ec2:StartInstances", "ec2:StopInstances","ec2:DescribeInstances"]
    resources = ["*"]
  }

}
# 4. Create a named IAM policy from the document
resource "aws_iam_policy" "policy-lambda-func" {
  name = "lambda-policy"
  policy =data.aws_iam_policy.iam-lambda-policy.json
}

# 5. Attach the IAM policy to the Lambda's role
resource "aws_iam_role_policy_attachment" "attach-role-policy" {
  role = aws_iam_role.rule-lambda-func.name
  policy_arn = aws_iam_policy.policy-lambda-func.arn
}

resource "aws_lambda_function" "ec2-status-func" {
    role = ""
  function_name = "ec2-status-func"

}


data "archive_file" "py-func"{
  type = "zip"
  source_file = ""
  output_path = ""

}
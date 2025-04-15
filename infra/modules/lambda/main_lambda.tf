#**** 5 elements to define: 
# aws_iam_role
# aws_iam_policy
# aws_iam_role_policy_attachment
# data "archive_file"
# aws_lambda_function

# 1. Trust policy for Lambda to assume the role
data "aws_iam_policy_document" "lambda-assume-role-doc"{
  version ="2012-10-17"
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
resource "aws_iam_role" "role-lambda-func" {
  # create the trust policy / assume the role policy
  # Who/what is allowed to assume this role?
  # It’s attached to the role itself.
  # Defines who can use the role, not what the role can do.
  name = "role-lambda-func"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role-doc.json
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
  policy =data.aws_iam_policy_document.iam-lambda-policy.json
}

# 5. Attach the IAM policy to the Lambda's role
resource "aws_iam_role_policy_attachment" "attach-role-policy" {
  role = aws_iam_role.role-lambda-func.name
  policy_arn = aws_iam_policy.policy-lambda-func.arn
}

data "archive_file" "py-func-zip"{
  type = "zip"
  source_file = "../src/main_lambda.py"
  output_path = "${path.module}/src/function.zip"

}

resource "aws_lambda_function" "ec2-status-func" {
  function_name = "ec2-status-func"
  role = aws_iam_role.role-lambda-func.arn
  handler = "lambda_function.lambda_handler"
  #runtime = var.py_runtime
  runtime = "python3.9"
  filename = data.archive_file.py-func-zip.output_path
  source_code_hash = data.archive_file.py-func-zip.output_base64sha256
  timeout = 10
}


# resource null_resource + local-exec can be used to archive teh file, BUT
# - the archive command is os dependent
# - not tf native code 
# - less fast less clean
# - not meant for production

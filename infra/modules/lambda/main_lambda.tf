#**** 5 elements to define: 
# aws_iam_role
# aws_iam_policy
# aws_iam_role_policy_attachment
# data "archive_file"
# aws_lambda_function
#[ "ec2:StartInstances", "ec2:StopInstances","ec2:DescribeInstances"]

data "aws_iam_policy_document" "lamnda-assume-role-doc"{
  version = "04-10-2025"
  statement {
    effect = "Allow"
    actions = "sts:AssumeRole"
    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

#assume_role_policy = jsonencode({ ... })  // Trust policy
resource "aws_iam_role" "rule-lambda-func" {
  # create the trust policy / assume the role policy
  # Who/what is allowed to assume this role?
  # It’s attached to the role itself.
  # Defines who can use the role, not what the role can do.
  name = "rule-lambda-func"
  assume_role_policy = data.aws_iam_policy_document.lamnda-assume-role-doc
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
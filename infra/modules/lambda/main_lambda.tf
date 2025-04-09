#**** 5 elements to define: 
# aws_iam_role
# aws_iam_policy
# aws_iam_role_policy_attachment
# data "archive_file"
# aws_lambda_function

resource "aws_lambda_function" "ec2-status-func" {
    role = 
  function_name = "ec2-status-func"

}
output "out_lambda_func_name" {
  value = aws_lambda_function.ec2-status-func.function_name
}

output "out_lambda_func_arn" {
  value = aws_lambda_function.ec2-status-func.arn
}
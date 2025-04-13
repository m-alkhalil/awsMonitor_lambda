variable "ec2_event_rule_name" {
  description = "could watch event rule name"
  type = string
}

variable "lambda_func_name" { 
  description = "lambda function name"
  type = string
}

variable "lambda_function_arn" {
  description = "lambda function arn"
  type = string
}

variable "sns_topic_arn" {
  description = "SNS topic arn"
  type = string
}
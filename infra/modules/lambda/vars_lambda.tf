variable "py_runtime" {
    description = "python run time version"
    type = string
}

variable "SNS_TOPIC_ARN" {
  description = "sns topic arn, to be passed as an env var."
}
variable "lockingS3-region" {
  description = "locking s3 bucket region location"
}

variable "s3-bucket-locking-key" {
  description = "Terraform locking file in teh s3 bucket"
  default = "awsMonitor-infra-s3-backend"
}

variable "aws-tf-profile" {
  description = "aws configuration profile to use with terraform"
}
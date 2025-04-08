variable "vpc-cidr" {
    description = "VPC-CIDR "
}

variable "s3-backend-region" {
  description = "S3 bucket region-remote backend"
  default = "awsMonitor-infra-s3-backend"
}
variable "public-subnets-cidr" {
  type = list(string)
  description = "CIDR block of the main public subnet"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private-subnets-cidr" {
  type = list(string)
  description = "CIDR block of the private subnet"
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}
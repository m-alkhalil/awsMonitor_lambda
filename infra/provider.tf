terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
 
  backend "s3" {
    bucket = "awsMonitor-infra-s3-backend"
    key = var.s3-bucket-locking-key
    region = var.lockingS3-region
    encrypt = true
    use_lockfile = true
  }
    
}
provider "aws" {
  alias = "Ohio"
  region = "us-east-2"
  profile = var.aws-tf-profile
}
provider "aws" {
  alias = "N-Verginia"
  region = "us-east-1"
  profile = var.aws-tf-profile
}
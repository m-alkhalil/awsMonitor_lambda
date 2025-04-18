terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      
    }
    
  }
 
  backend "s3" {
    bucket = "awsmonitor-infra-s3-backend"
    key = "state/terrafrom.tfstate"
    region = "us-east-2"
    encrypt = true
    #use_lockfile = true
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
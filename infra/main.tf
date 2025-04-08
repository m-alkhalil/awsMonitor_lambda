# when writing tf project, the structure must be split in different tf files 
#provider.tf
#input.tf 
#output.tf 
#main.tf

module "vpc" {
    source = "./modules/vpc"
    vpc-cidr = "10.0.0.0/16"
  
}

module "ec2" {
  source = "./modules/ec2"
  ec2-ami = "ami-00a929b66ed6e0de6"
  subnet-ids = module.vpc.infra-public-subnet_ids
}
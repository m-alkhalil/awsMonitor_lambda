# create vpc
# create subnet / public
# create igw
#create rout
#create association
# > ec2 can be created and assigned with the public subnet.

resource "aws_vpc" "infra_vpc" {
    cidr_block = var.vpc-cidr
    tags = {
        Name = "Infra_VPC"
    }
}

output "infra_vpc" {
  value = aws.infra_vpc.Id
}
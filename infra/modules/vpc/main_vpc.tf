# create vpc
# create subnet / public
# create igw
# create rout table
# create routs in route table to route traffic to the igw
# create association, associate route table with the subnet
# > ec2 can be created and assigned with the public subnet.

resource "aws_vpc" "infra_vpc" {
    cidr_block = var.vpc-cidr
    tags = {
        Name = "Infra_VPC"
    }
}
#to create subnets in multiple az create a varialble to hold multiple az, then 
#availability_zone = element(var.azs, count.index)
resource "aws_subnet" "infra-public-subnets" {
  count = length(var.public-subnets-cidr)
  vpc_id = aws_vpc.infra_vpc.id
  cidr_block = element(var.public-subnets-cidr, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "infra-public subnet ${count.index + 1} "
  }
}
resource "aws_internet_gateway" "infra-igw" {
  vpc_id = aws_vpc.infra_vpc.id
  tags = {
    Name = "Infra internet gateway"
  }  
}
resource "aws_route_table" "infra-route" {
  vpc_id = aws_vpc.infra_vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra-igw.id
  }
}
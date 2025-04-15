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
resource "aws_security_group" "infra-ssh-sg" {
  vpc_id = aws_vpc.infra_vpc.id
  name = "SSH-sg"
  description = "SG SSH connection"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = " SSH_SG"
  }
}
resource "aws_security_group" "infra-http-s-sg" {
  vpc_id = aws_vpc.infra_vpc.id
  name = "Http-Https-SG"
  description = "SG for https https rules"
  ingress  {
    from_port = 433
    to_port = 433
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "http_https-sg"
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
#   resource "aws_subnet" "example" {
#   for_each = toset(var.subnet_cidrs) # This will create a subnet for each CIDR in the list

#   vpc_id            = aws_vpc.example.id
#   cidr_block        = each.value
#   availability_zone = "us-east-1a"  # Example AZ, you can use a dynamic selection if needed
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "Example Subnet ${each.value}"
#   }
# }
}
resource "aws_internet_gateway" "infra-igw" {
  vpc_id = aws_vpc.infra_vpc.id
  tags = {
    Name = "Infra internet gateway"
  }  
}
resource "aws_route_table" "infra-route-table" {
  vpc_id = aws_vpc.infra_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra-igw.id
  }
  tags = {
      Name = "DEV-infra route table"
      }
}
#**** The route resource is defined in the route {} block in teh route table resource
# resource "aws_route" "infra-route" {
#   route_table_id = aws_route_table.infra-route-table
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id = aws_internet_gateway.infra-igw.id
# }

resource "aws_route_table_association" "infra-public-subnet-association" {
  #for_each =  toset(aws_subnet.infra-public-subnets[*].id)
  for_each = { for idx, subnet_id in aws_subnet.infra-public-subnets : idx => subnet_id.id }
  subnet_id = each.value
  route_table_id = aws_route_table.infra-route-table.id
}
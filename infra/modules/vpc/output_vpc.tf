output "inra-vpc-id" {
    value = aws_vpc.infra_vpc.id
}

output "infra-public-subnets-ids" {
  value = aws_subnet.infra-public-subnets[*].id
}
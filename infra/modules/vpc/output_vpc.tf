output "inra-vpc-id" {
    value = aws_vpc.infra_vpc.id
}

output "infra-public-subnets-ids" {
  value = aws_subnet.infra-public-subnets[*].id
}

output "ssh-sg-id" {
  value = aws_security_group.infra-ssh-sg.id
}
output "http-sg-id"{
  value = aws_security_group.infra-http-s-sg.id
}
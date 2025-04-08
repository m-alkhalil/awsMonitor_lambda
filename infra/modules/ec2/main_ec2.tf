resource "aws_instance" "test-server" {
  ami = var.ec2-ami
  instance_type = var.ec2-type
  subnet_id = var.subnet_ids[0]
  associate_public_ip_address = true
  key_name = var.ec2-key-name
  monitoring = true
  security_groups = var.ec2-sg-ids
tags = {
  Name = "test-server"
}
}
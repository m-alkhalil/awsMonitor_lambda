variable "ec2-ami" {
    description = "ec2 instance ami id"
    type = string
  
}
variable "subnet-ids" {
    description = "ec2 subnet Id"
    type = list(string)
  
}
variable "ec2-key-name" {
    description = " ssh access key name"
}
variable "ec2-type" {
  description = " ec2 instance type"
  default = "t2.micro"
}
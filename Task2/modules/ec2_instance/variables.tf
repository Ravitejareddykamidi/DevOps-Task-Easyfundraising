variable "key_name" {
  description = "Name of the AWS key pair"
}

variable "subnet_id" {
  description = "ID of the subnet where the EC2 instance will be launched"
}

variable "security_group_ids" {
  description = "List of security group IDs"
}

variable "ami_id" {
    description = "ami_id for bastion host"
  
}

variable "instance" {
    description = "bastion host instance type"
  
}
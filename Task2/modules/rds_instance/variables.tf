// modules/rds_instance/variables.tf

variable "identifier" {
  description = "Unique identifier for the RDS instance"
}

variable "environment" {
  description = "Environment for the RDS instance"
}

variable "instance_class" {
  description = "Instance class for the RDS instance"
}

variable "multi_az" {
  description = "Whether the RDS instance should be multi-AZ"
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
}

variable "subnet_group_name" {
  description = "Name of the DB subnet group"
}

variable "users" {
  description = "A list of users to create in the RDS instance"
  type        = list(object({
    username = string
  }))
  default     = []
}

variable "username" {
  description = "this will be default username"
  
}

variable "password" {
  description = "to get from secerts or encrypt using kms"

}
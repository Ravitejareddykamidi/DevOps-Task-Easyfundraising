# modules/rds_user/variables.tf
variable "rds_users" {
  type = list(object({
    user = string
    host = string
  }))
}

variable "user" {
  default = "admin"
  description = "this will be default username"
  
}

variable "masterpassword" {
  description = "to get from secerts or encrypt using kms"
  default = "admin1234"
}

variable "hostname" {
    description = "hostname of rds database"
  
}
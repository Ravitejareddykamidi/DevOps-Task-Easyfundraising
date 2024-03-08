terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }

    mysql = {
      source = "petoju/mysql"
      version = "3.0.48"
    }
    
  }

  required_version = "~> 1.3"
}
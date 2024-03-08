terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "task2easyfundraising-state"
    dynamodb_table = "task2terraform-state-lock-dynamo"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
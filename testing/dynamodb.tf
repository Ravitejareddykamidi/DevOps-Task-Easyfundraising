provider "aws" {
  region     = "us-east-1"
}

resource "aws_s3_bucket" "tf_s3" {
    
    bucket = "easyfundraising-state"
    acl = "private"
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}
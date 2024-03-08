data "terraform_remote_state" "vpc_subnet" {
  backend = "s3"

  config = {
    bucket         = "easyfundraising-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

data "aws_secretsmanager_secret" "by-arn" {
  # arn = aws_secretsmanager_secret.secert.arn
  arn = "arn:aws:secretsmanager:${var.aws_region}:${var.aws_profile}:secret:rds/${var.secret_name}"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.by-arn.id
}

output "eks_cluster_vpc_id" {
  value = data.terraform_remote_state.vpc_subnet.outputs.vpc_id
}

output "eks_cluster_private_subnet_ids" {
  value = data.terraform_remote_state.vpc_subnet.outputs.private_subnet_ids
}

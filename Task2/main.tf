resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "private_subnet_db"
  subnet_ids = [for subnet in data.terraform_remote_state.vpc_subnet.outputs.private_subnet_ids : subnet]

  tags = {
    Name = "private subnet group for rds"
  }
}

module "dev_rds" {
  source              = "./modules/rds_instance"
  environment         = "Dev"
  instance_class      = "db.t2.micro"
  multi_az            = false
  vpc_security_group_ids = [aws_security_group.rdssg.id]
  subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  username              = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["username"]
  password          = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["password"]
  identifier          = "development-rds"
}

module "staging_rds" {
  source              = "./modules/rds_instance"
  environment         = "Staging"
  instance_class      = "db.t2.small"
  multi_az            = true
  vpc_security_group_ids = [aws_security_group.rdssg.id]
  subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  username              =        jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["username"]
  password          = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["password"]
  identifier          = "staging-rds"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  key_name      = "esyfund.pub"
  ami_id        = "ami-09e67e426f25ce0d7"
  instance       =  "t2.micro"
  subnet_id     = data.terraform_remote_state.vpc_subnet.outputs.public_subnet_ids[0]
  security_group_ids = [aws_security_group.ec2-sg.id]
}

provider "mysql" {
    
    endpoint = "127.0.0.1:33306"
    username = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["username"]
    password = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["password"]
}

# module "rds_users_dev" {
#   source       = "./modules/rds_users"
#   rds_users    = [
#     {
#       user = "testing_sample"
#     },
#     {
#       user = "testing2_sample"
#     },
#     # Add more users as needed
#   ]
#   hostname  = "${module.dev_rds.address}"  # Set your common host here
# }

# module "rds_users_staging" {
#   source       = "./modules/rds_users"
#   rds_users    = [
#     {
#       user = "testing_staging"
#     },
#     {
#       user = "testing2_staging"
#     },
#     # Add more users as needed
#   ]
#   hostname  = "${module.staging_rds.address}"  # Set your common host here
# }
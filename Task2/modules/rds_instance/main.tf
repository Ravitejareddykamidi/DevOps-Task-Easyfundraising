// modules/rds_instance/main.tf
resource "aws_db_instance" "rds_instance" {
  identifier           = var.identifier
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  multi_az             = var.multi_az
  username             = var.username
  password             =  var.password
  publicly_accessible  = false
  storage_type         = "gp2"
  allocated_storage    = 20

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.subnet_group_name

  skip_final_snapshot   = true
  apply_immediately     = true

  tags = {
    Name        = var.identifier
    Environment = var.environment
  }
}


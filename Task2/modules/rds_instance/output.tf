output "identifier" {
  value = aws_db_instance.rds_instance.identifier
}

output "instance_class" {
  value = aws_db_instance.rds_instance.instance_class
}

output "address" {
    value = aws_db_instance.rds_instance.address
  
}
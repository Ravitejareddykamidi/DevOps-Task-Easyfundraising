# modules/rds_user/main.tf
# Create an SSH tunnel
resource "null_resource" "ssh_tunnel" {
  provisioner "local-exec" {
    command = "ssh -L 33306:${var.hostname}:3306 ubuntu@${module.ec2_instance.bastion_public_ip} -i esyfund -N"
  }

  depends_on = [mysql_user.rds_users]
}


# provider "mysql" {
    
#     endpoint = "127.0.0.1:33306"
#     username = var.user
#     password = var.masterpassword
# }


resource "random_password" "rds_user_passwords" {
  count    = length(var.rds_users)
  length   = 16
  special  = true
  upper    = true
  lower    = true
  number   = true
}

resource "mysql_user" "rds_users" {
  count              = length(var.rds_users)
  user               = var.rds_users[count.index].user
  host               = var.hostname
  plaintext_password = random_password.rds_user_passwords[count.index].result
}

resource "mysql_grant" "rds_users" {
  count = length(mysql_user.rds_users)

  user       = mysql_user.rds_users[count.index].user
  host       = var.hostname
  database   = "app"
  privileges = ["ALL"]
}
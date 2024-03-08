resource "aws_key_pair" "key_kp" {
  key_name   = "esy-fund"
  public_key = file("esyfund.pub")
}


resource "aws_instance" "bastion_host" {
  ami           = var.ami_id
  instance_type = var.instance
  key_name      = aws_key_pair.key_kp.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "bastion-host-rds"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("esyfund")
    host        = aws_instance.bastion_host.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y mysql-client-8.0",  # Explicitly install MySQL client version 8.0
      "sudo dpkg --configure -a",  # Configure broken packages
      "sudo apt-get install -f",
      # Additional MySQL configurations or commands as needed
    ]
  }
}

resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion_host.id
  vpc      = true

  tags = {
    Name = "bastion_eip_rds"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion_host.public_ip
}
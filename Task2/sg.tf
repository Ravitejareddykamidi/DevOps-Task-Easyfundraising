resource "aws_security_group" "ec2-sg" {
    name = "ec2-rdssg"
    vpc_id = data.terraform_remote_state.vpc_subnet.outputs.vpc_id

   ingress {
    description = "Allow all traffic through HTTP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
     ingress {
    description = "Allow SSH from my computer"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    // This is using the variable "my_ip"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ec2_sg_id" {
    value = aws_security_group.ec2-sg.id
  
}
resource "aws_security_group" "rdssg" {
    name = "rdssg"
    vpc_id = data.terraform_remote_state.vpc_subnet.outputs.vpc_id

    ingress {
    description     = "Allow MySQL traffic from only the web sg"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2-sg.id]
  }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}
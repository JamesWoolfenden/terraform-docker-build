resource "aws_security_group" "docker-compose" {
  name        = "docker-compose-${var.environment}"
  description = "Terraform docker-compose security group"

  
  ingress {
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["${var.access_ip}"]
  }

  ingress {
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

  egress {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags  = {
        "Name"        = "docker-compose-${var.environment}"
        "Environment" = "${var.environment}"
        "Role" = "Docker-Compose"
  }
}

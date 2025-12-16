terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "app_sg" {
  name_prefix = "flask-app-sg-"
  description = "Allow HTTP access to Flask app"

  ingress {
    description = "Flask app"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "flask_app" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.app_sg.id]

  user_data = <<EOF
#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

docker pull 0miniflyer0/it-management-and-dev-ops-final:latest
docker run -d -p 5000:5000 0miniflyer0/it-management-and-dev-ops-final:latest
EOF

  tags = {
    Name = "flask-app"
  }
}

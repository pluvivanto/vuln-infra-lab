provider "aws" {
  region = "us-east-1"
}

provider "http" {}

resource "tls_private_key" "kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "lab_kp" {
  key_name   = "juice-lab-kp"
  public_key = tls_private_key.kp.public_key_openssh
}

resource "local_file" "pem_file" {
  content         = tls_private_key.kp.private_key_pem
  filename        = "${path.module}/juice-lab-kp.pem"
  file_permission = "0400"
}

resource "aws_instance" "juiceshop" {
  ami                         = "ami-05c17b22914ce7378" # Ubuntu 24.04LTS us-east-1	arm64
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.lab_kp.key_name
  vpc_security_group_ids      = [aws_security_group.sg_allow_ssh_http.id]
  associate_public_ip_address = false
  tags = {
    Name = "mytest-juiceShop"
  }

  user_data                   = <<-EOF
  #!/usr/bin/env bash
  set -e
  apt-get update
  apt-get install -y docker.io
  docker run -d --name juice -p 80:3000 bkimminich/juice-shop
EOF
}

resource "aws_eip" "juice_ip" {
  instance = aws_instance.juiceshop.id
  domain   = "vpc"
}

resource "aws_security_group" "sg_allow_ssh_http" {
  name = "mytest-juiceshop-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

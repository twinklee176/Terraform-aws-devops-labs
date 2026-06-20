provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami                         = "ami-0f58b397bc5c1f2e8"
  instance_type               = "t3.micro"
  associate_public_ip_address = false

  tags = {
    Name = "private-server"
  }
}

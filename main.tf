provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-03ff931c79d0e2c80"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

resource "random_string" "random" {
  length = 16
}

resource "aws_vpc" "demovpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "demovpc"
  }
}

resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "demo-private-${random_string.random.id}"
  }
}

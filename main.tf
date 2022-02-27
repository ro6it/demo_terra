provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "var.ami-id"
  instance_type = "var.instancesize"
  subnet_id     = aws_subnet.privatesubnet.id

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

resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demovpc.id

  tags = {
    Name = "igw-${random_string.random.id}"
  }
}

variable "instancesize" {
  type = string
  default = "m5.large"
}

variable "ami-id" {
  type = string
  default = "ami-0c19f80dba70861db"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  # Here, ami refers to AMI ID. Can get this from ec2 ami section
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t3.nano"

  tags = {
    Name = "SampleServer"
  }
}


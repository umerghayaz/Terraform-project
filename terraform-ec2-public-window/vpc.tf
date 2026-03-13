resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-vpc"
  }
}

resource "aws_vpc" "vpc2" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "terraform-vpc-2"
  }
}
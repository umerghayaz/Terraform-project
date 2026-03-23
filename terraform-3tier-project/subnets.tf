# ─────────────────────────────────────────────────────────────
# Public Subnets
# ─────────────────────────────────────────────────────────────

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-web-subnet-az-1"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-web-subnet-az-2"
  }
}

# ─────────────────────────────────────────────────────────────
# Private Subnets
# ─────────────────────────────────────────────────────────────

resource "aws_subnet" "private_a1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-app-subnet-az-1"
  }
}

resource "aws_subnet" "private_a2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-app-subnet-az-2"
  }
}

resource "aws_subnet" "private_b1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-db-subnet-az-1"
  }
}

resource "aws_subnet" "private_b2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-db-subnet-az-2"
  }
}


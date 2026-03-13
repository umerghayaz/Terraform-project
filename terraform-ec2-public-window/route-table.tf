resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "vpc2_public_rt" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc2_igw.id
  }

  tags = {
    Name = "vpc2-public-rt"
  }
}
resource "aws_route_table_association" "vpc2_public_assoc1" {
  subnet_id      = aws_subnet.vpc2_public_subnet_1.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}

resource "aws_route_table_association" "vpc2_public_assoc2" {
  subnet_id      = aws_subnet.vpc2_public_subnet_2.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}
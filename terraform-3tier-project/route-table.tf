# Public route table (with Internet Gateway route)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Private route table (no internet route)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-rt"
  }
}

# ─────────────────────────────────────────────────────────────
# Route Table Associations
# ─────────────────────────────────────────────────────────────

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a1" {
  subnet_id      = aws_subnet.private_a1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_a2" {
  subnet_id      = aws_subnet.private_a2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b1" {
  subnet_id      = aws_subnet.private_b1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b2" {
  subnet_id      = aws_subnet.private_b2.id
  route_table_id = aws_route_table.private.id
}
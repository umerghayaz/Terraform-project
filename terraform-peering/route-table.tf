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

# VPC1 ke liye private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = { Name = "private-rt" }
}

resource "aws_route" "private_to_vpc2" {
  route_table_id            = aws_route_table.private_rt.id
  destination_cidr_block    = "20.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2_peer.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
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

# ──────────────────────────────────────────────────────────────
# VPC2 ke liye Private Route Table
# ──────────────────────────────────────────────────────────────

resource "aws_route_table" "vpc2_private_rt" {
  vpc_id = aws_vpc.vpc2.id
  
  tags = {
    Name = "vpc2-private-rt"
  }
}

# Peering route: VPC2 se VPC1 (10.0.0.0/16) ki taraf
resource "aws_route" "vpc2_private_to_vpc1" {
  route_table_id            = aws_route_table.vpc2_private_rt.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2_peer.id
}

# Private subnets ko is route table se jod do
resource "aws_route_table_association" "vpc2_private_assoc1" {
  subnet_id      = aws_subnet.vpc2_private_subnet_1.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}

resource "aws_route_table_association" "vpc2_private_assoc2" {
  subnet_id      = aws_subnet.vpc2_private_subnet_2.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}
resource "aws_vpc_peering_connection" "vpc1_vpc2_peer" {
  vpc_id      = aws_vpc.main_vpc.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true

  tags = {
    Name = "vpc1-to-vpc2-peering"
  }
}

resource "aws_route" "vpc1_to_vpc2" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = "20.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2_peer.id
}

resource "aws_route" "vpc2_to_vpc1" {
  route_table_id            = aws_route_table.vpc2_public_rt.id
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2_peer.id
}
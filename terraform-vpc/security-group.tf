resource "aws_security_group" "rdp_sg" {
  name   = "allow-rdp-http"
  vpc_id = aws_vpc.main_vpc.id

  # Allow RDP (3389)
  ingress {
    description = "RDP Access"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP (80)
  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # 🔹 ADD THIS
  ingress {
    description = "Allow Ping from VPC2"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["20.0.0.0/16"]
  }
  # Outbound rule (allow all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


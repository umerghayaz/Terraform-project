data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}
resource "aws_security_group" "internetfacing-lb-sg" {
  name        = "internetfacing-lb-sg"
  description = "for tsting"
  vpc_id      = aws_vpc.main.id



  # Inbound: HTTP (port 80) - open to the world
  ingress {
    description = "HTTP Access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "${chomp(data.http.my_ip.response_body)}/32"
    ]  
    }



  # Outbound: Allow all traffic (common default for most EC2/Windows instances)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # -1 = all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "allow-rdp-http"
    ManagedBy = "Terraform"
  }
}
#==================================sg2=====================================
resource "aws_security_group" "webtier_sg" {
  name        = "webtier_sg"
  description = "for tsting"
  vpc_id      = aws_vpc.main.id



  # Inbound: HTTP (port 80) - open to the world
  ingress {
    description = "HTTP Access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "${chomp(data.http.my_ip.response_body)}/32"
    ]  
    }
# Inbound: HTTP (port 80) from this same security group (self-reference)
  ingress {
    description = "HTTP from instances in the same security group (self)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    # This is the self-reference - allows traffic from any resource tagged with this SG
    security_groups = [aws_security_group.internetfacing-lb-sg.id]
  }


  # Outbound: Allow all traffic (common default for most EC2/Windows instances)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # -1 = all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "webtier_sg"
    ManagedBy = "Terraform"
  }
}
#==================================sg3=====================================
resource "aws_security_group" "internal-lb-sg" {
  name        = "internal-lb-sg"
  description = "for tsting"
  vpc_id      = aws_vpc.main.id




# Inbound: HTTP (port 80) from this same security group (self-reference)
  ingress {
    description = "HTTP from instances in the same security group (self)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    # This is the self-reference - allows traffic from any resource tagged with this SG
    security_groups = [aws_security_group.webtier_sg.id]
  }


  # Outbound: Allow all traffic (common default for most EC2/Windows instances)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # -1 = all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "internal-lb-sg"
    ManagedBy = "Terraform"
  }
}

#==================================sg4=====================================
resource "aws_security_group" "privateinstance-sg" {
  name        = "privateinstance-sg"
  description = "for tsting"
  vpc_id      = aws_vpc.main.id



  # Inbound: HTTP (port 80) - open to the world
  ingress {
    description = "HTTP Access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "${chomp(data.http.my_ip.response_body)}/32"
    ]  
    }
# Inbound: HTTP (port 80) from this same security group (self-reference)
  ingress {
    description = "HTTP from instances in the same security group (self)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    # This is the self-reference - allows traffic from any resource tagged with this SG
    security_groups = [aws_security_group.internal-lb-sg.id]
  }


  # Outbound: Allow all traffic (common default for most EC2/Windows instances)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # -1 = all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "privateinstance-sg"
    ManagedBy = "Terraform"
  }
}

#==================================sg5=====================================
resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "for tsting"
  vpc_id      = aws_vpc.main.id




# Inbound: HTTP (port 80) from this same security group (self-reference)
  ingress {
    description = "HTTP from instances in the same security group (self)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    # This is the self-reference - allows traffic from any resource tagged with this SG
    security_groups = [aws_security_group.privateinstance-sg.id]
  }


  # Outbound: Allow all traffic (common default for most EC2/Windows instances)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # -1 = all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "db-sg"
    ManagedBy = "Terraform"
  }
}

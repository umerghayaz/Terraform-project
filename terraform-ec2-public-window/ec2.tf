data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
}

resource "aws_instance" "windows_server" {
  ami                    = data.aws_ami.windows.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.rdp_sg.id]
  key_name               = "umer-kp"

  tags = {
    Name = "terraform-windows-server"
  }
}
resource "aws_instance" "private_windows_server" {
  ami                    = data.aws_ami.windows.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.rdp_sg.id]
  key_name               = "umer-kp"
  associate_public_ip_address = false

  tags = {
    Name = "terraform-private-windows-server"
  }
}


resource "aws_instance" "vpc2_windows_public" {
  ami                    = data.aws_ami.windows.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.vpc2_public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.vpc2_rdp_sg.id]
  key_name               = "umer-kp"

  tags = {
    Name = "vpc2-public-windows"
  }
}
resource "aws_instance" "vpc2_windows_private" {
  ami                    = data.aws_ami.windows.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.vpc2_private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.vpc2_rdp_sg.id]
  key_name               = "umer-kp"
  associate_public_ip_address = false

  tags = {
    Name = "vpc2-private-windows"
  }
}
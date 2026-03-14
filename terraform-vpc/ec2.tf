data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
}

resource "aws_instance" "public_windows_server" {
  ami                    = data.aws_ami.windows.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.rdp_sg.id]
  key_name               = "umer-kp"
  associate_public_ip_address = true
# Yeh sab se important: user_data PowerShell script
  user_data = <<EOF
<powershell>
# Install IIS + management tools
Install-WindowsFeature -name Web-Server -IncludeManagementTools

</powershell>
EOF
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


# -----------------------------
# Get Latest Amazon Linux AMI
# -----------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# -----------------------------
# EC2 Instance
# -----------------------------
resource "aws_instance" "private_ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"   # ✅ Free tier
  subnet_id                   = aws_subnet.private_a1.id
  vpc_security_group_ids      = [aws_security_group.privateinstance-sg.id]
  associate_public_ip_address = false        # ✅ Explicitly OFF
  key_name               = "umer-kp"

  tags = {
    Name = "Private-EC2"
  }
}
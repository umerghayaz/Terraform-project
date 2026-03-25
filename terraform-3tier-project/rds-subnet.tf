# -----------------------------
# DB Subnet Group
# -----------------------------
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-rds-subnet-group"
  description = "RDS subnet group"

  subnet_ids = [
    aws_subnet.private_b1.id,
    aws_subnet.private_b2.id
  ]

  tags = {
    Name = "rds-subnet-group"
  }
}

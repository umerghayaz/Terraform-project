# -----------------------------
# RDS Instance (PostgreSQL - Free Tier)
# -----------------------------
resource "aws_db_instance" "postgres" {
  identifier              = "mypostgres-db"
  engine                  = "postgres"
engine_version = "12"

  instance_class          = "db.t3.micro"   # ✅ Free tier eligible
  allocated_storage       = 20              # ✅ Max free tier limit
  storage_type            = "gp2"

  db_name                 = "mydb"
  username                = "postgres"
  password                = "Admin12345"

  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db-sg.id]

  publicly_accessible     = false
  multi_az                = false           # ❌ Multi-AZ not free
  skip_final_snapshot     = true

  # Optional (keep minimal for free tier)
  backup_retention_period = 0               # disables backups (or set 1–7 if needed)

  tags = {
    Name = "Postgres-FreeTier"
  }
}
resource "aws_db_subnet_group" "this" {
  name = "${var.environment}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.environment}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "this" {
  identifier = "${var.environment}-database"

  engine         = var.engine
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.database_name
  username = var.master_username
  password = var.master_password

  port = 5432

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.database_security_group_id]

  multi_az = var.multi_az

  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false
  backup_retention_period = 7

  tags = {
    Name        = "${var.environment}-database"
    Environment = var.environment
  }
}

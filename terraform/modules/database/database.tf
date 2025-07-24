resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "app-db"
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_username
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = var.security_group_ids
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "appdb-instance"
  }
}
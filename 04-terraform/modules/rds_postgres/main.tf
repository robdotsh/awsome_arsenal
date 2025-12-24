resource "aws_db_instance" "this" {
  allocated_storage      = var.rds_allocated_storage_gb
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = var.subnet_group_name
  tags                   = var.tags
}

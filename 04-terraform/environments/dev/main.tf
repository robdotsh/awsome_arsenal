provider "aws" {
  region = "us-east-1"
}

module "ecs" {
  source             = "../../modules/ecs_fargate"
  cluster_name       = "dev-cluster"
  task_family        = "dev-task"
  container_name     = "app"
  container_image    = "nginx:latest"
  cpu                = 256
  memory             = 512
  container_port     = 80
  container_env      = []
  service_name       = "dev-service"
  desired_count      = 1
  subnet_ids         = ["subnet-12345678"]
  security_group_ids = ["sg-12345678"]
}

module "postgres" {
  source              = "../../modules/rds_postgres"
  allocated_storage   = 20
  engine_version      = "13.9"
  instance_class      = "db.t3.micro"
  db_name             = "devdb"
  username            = "admin"
  password            = "password123"
  publicly_accessible = false
  security_group_ids  = ["sg-12345678"]
  subnet_group_name   = "dev-subnet-group"
}

module "dynamodb" {
  source        = "../../modules/dynamodb_table"
  table_name    = "dev-table"
  hash_key      = "id"
  hash_key_type = "S"
  tags          = { Environment = "dev" }
}

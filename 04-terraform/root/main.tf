# provider "aws" {
#   region = var.aws_region
# }

# # ECS Fargate
# module "ecs" {
#   source = "../modules/ecs_fargate"

#   cluster_name  = "${local.name_prefix}-cluster"
#   container_env = var.container_env

#   task_family     = var.task_family
#   container_name  = var.container_name
#   container_image = var.container_image
#   cpu             = var.cpu
#   memory          = var.memory

#   container_port     = var.container_port
#   service_name       = var.service_name
#   desired_count      = var.desired_count
#   subnet_ids         = var.subnet_ids
#   security_group_ids = var.security_group_ids
#   environment        = var.environment
#   tags               = local.common_tags
# }

# # RDS PostgreSQL
# module "postgres" {
#   source              = "../modules/rds_postgres"
#   allocated_storage   = var.rds_allocated_storage
#   rds_engine_version  = var.rds_engine_version
#   instance_class      = var.rds_instance_class
#   db_name             = "${local.name_prefix}-cluster"
#   username            = var.rds_username
#   password            = var.rds_password
#   publicly_accessible = var.rds_publicly_accessible
#   security_group_ids  = var.security_group_ids
#   subnet_group_name   = var.rds_subnet_group_name
#   tags                = local.common_tags
# }

# # DynamoDB Table
# module "dynamodb" {
#   source        = "../modules/dynamodb_table"
#   table_name    = var.dynamodb_table_name
#   hash_key      = var.dynamodb_hash_key
#   hash_key_type = var.dynamodb_hash_key_type
#   tags          = merge(var.dynamodb_tags, local.common_tags)
# }

# AzureDevOps proj
module "eShopOnWeb_MultiStageYAML" {
  source                = "../../04-terraform/azure-devops"
  environment           = var.environment
  project_name          = var.project_name
  project_description   = var.project_description
  project_id            = var.project_id
  visibility            = var.visibility
  org_service_url       = var.org_service_url
  personal_access_token = var.personal_access_token
  member_emails         = var.member_emails
  location              = var.location
}

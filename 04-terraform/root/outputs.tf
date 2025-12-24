output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "rds_endpoint" {
  value = module.postgres.endpoint
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

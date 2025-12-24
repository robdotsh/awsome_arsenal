# AWS
variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

# ECS Fargate
variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "task_family" {
  description = "ECS task definition family"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image URI"
  type        = string
}

variable "cpu" {
  description = "CPU units for the ECS task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory (MiB) for the ECS task"
  type        = number
  default     = 512
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 80
}

variable "container_env" {
  description = "Environment variables for the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "service_name" {
  description = "ECS service name"
  type        = string
}

variable "desired_count" {
  description = "Number of desired ECS tasks"
  type        = number
  default     = 1
}


# RDS
variable "rds_allocated_storage" {
  description = "Allocated storage (GB)"
  type        = number
  default     = 20
}

variable "rds_engine" {
  description = "Database engine for RDS"
  type        = string
  default     = "postgres"

  validation {
    condition     = contains(["postgres", "mysql", "mariadb"], var.rds_engine)
    error_message = "rds_engine must be one of: postgres, mysql, mariadb."
  }
}

variable "rds_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "13.9"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_db_name" {
  description = "Database name"
  type        = string
}

variable "rds_username" {
  description = "Master database username"
  type        = string
}

variable "rds_password" {
  description = "Master database password"
  type        = string
  sensitive   = true
}

variable "rds_publicly_accessible" {
  description = "Whether the database is publicly accessible"
  type        = bool
  default     = false
}

variable "rds_subnet_group_name" {
  description = "RDS subnet group name"
  type        = string
}

# DynamoDB
variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "dynamodb_hash_key" {
  description = "DynamoDB hash key name"
  type        = string
}

variable "dynamodb_hash_key_type" {
  description = "DynamoDB hash key type"
  type        = string
  default     = "S"

  validation {
    condition     = contains(["S", "N", "B"], var.dynamodb_hash_key_type)
    error_message = "Hash key type must be S, N, or B."
  }
}

variable "dynamodb_tags" {
  description = "Tags for the DynamoDB table"
  type        = map(string)
  default     = {}
}

# Networking
variable "subnet_ids" {
  description = "Subnet IDs for ECS and RDS"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs for ECS and RDS"
  type        = list(string)
}

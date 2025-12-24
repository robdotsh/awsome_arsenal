variable "allocated_storage" {
  type        = number
  description = "Allocated storage for the RDS instance in GB"
  default     = 10
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

  validation {
    condition = (
      (var.rds_engine == "postgres" && can(regex("^1[3-6]\\.", var.rds_engine_version))) ||
      (var.rds_engine == "mysql" && can(regex("^8\\.0", var.rds_engine_version))) ||
      (var.rds_engine == "mariadb" && can(regex("^10\\.", var.rds_engine_version)))
    )
    error_message = <<EOT
rds_engine_version does not match rds_engine.
Expected:
- postgres: 13.x–16.x
- mysql: 8.0.x
- mariadb: 10.x
EOT
  }
}

variable "instance_class" {
  type        = string
  description = "RDS instance class (size and capacity of the DB instance)"
  default     = "db.t3.micro"
}

variable "db_name" {
  type        = string
  description = "Initial database name to create in the RDS instance"
}

variable "username" {
  type        = string
  description = "Master database username"
}

variable "password" {
  type        = string
  description = "Master database password"
  sensitive   = true
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether the RDS instance should have a public IP address"
  default     = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the RDS instance"
}

variable "subnet_group_name" {
  type        = string
  description = "Name of the DB subnet group for the RDS instance"
}

variable "rds_instance_class" {
  description = "RDS instance class (e.g., free-tier-eligible micro for low traffic)"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage_gb" {
  description = "Allocated storage in GB (e.g., 20 GB for typical free-tier guidance)"
  type        = number
  default     = 20
}

variable "rds_multi_az" {
  description = "Whether to enable Multi-AZ for high availability (disable for most dev/free-tier use)"
  type        = bool
  default     = false
}

variable "rds_backup_retention_days" {
  description = "Number of days to retain automated backups (0 disables backups, e.g., for demos)"
  type        = number
  default     = 0
}

variable "rds_max_connections" {
  description = "Expected maximum number of DB connections for very low traffic workloads"
  type        = number
  default     = 5
}

variable "tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
  default     = {}
}

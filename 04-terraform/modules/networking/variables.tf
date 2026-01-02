variable "aws_region" {
  type        = string
  description = "AWS region where resources will be created."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment identifier"
  default     = "prod"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "environment must be one of: dev, stage, prod."
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "vpc_cidr_block must be a valid IPv4 CIDR, i.e: 10.0.0.0/16."
  }
}

variable "availability_zone_count" {
  type        = number
  description = "Number of Availability Zones to use for high availability (typically 2 or 3)."
  default     = 3

  validation {
    condition     = var.availability_zone_count >= 2 && var.availability_zone_count <= 3
    error_message = "availability_zone_count must be between 2 and 3."
  }
}

variable "nat_gateway_strategy" {
  type        = string
  description = "NAT gateway strategy: 'single' for cost-optimized (one NAT) or 'one_per_az' for high availability."
  default     = "one_per_az"

  validation {
    condition     = contains(["single", "one_per_az"], var.nat_gateway_strategy)
    error_message = "nat_gateway_strategy must be either 'single' or 'one_per_az'."
  }
}

variable "flow_logs_enabled" {
  type        = bool
  description = "Whether to enable VPC flow logs to CloudWatch Logs."
  default     = true
}

variable "flow_logs_retention_days" {
  type        = number
  description = "CloudWatch Logs retention (in days) for VPC flow logs."
  default     = 90

  validation {
    condition     = var.flow_logs_retention_days >= 1
    error_message = "flow_logs_retention_days must be at least 1."
  }
}

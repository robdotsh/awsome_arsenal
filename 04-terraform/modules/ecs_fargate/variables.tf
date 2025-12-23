variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster where the service will run"
}

variable "task_family" {
  type        = string
  description = "ECS task definition family name for this application"
}

variable "container_name" {
  type        = string
  description = "Name of the container definition in the ECS task"
}

variable "container_image" {
  type        = string
  description = "Container image URI to deploy (an ECR image)"
}

variable "cpu" {
  type        = number
  description = "CPU units reserved for the ECS task (256 for a small Fargate task)"
  default     = 256
}

variable "memory" {
  type        = number
  description = "Memory in MiB reserved for the ECS task (512 for a small Fargate task)"
  default     = 512
}

variable "container_port" {
  type        = number
  description = "Application port exposed by the container"
  default     = 80
}

variable "container_env" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Environment variables to inject into the container"
}

variable "service_name" {
  type        = string
  description = "Name of the ECS service"
}

variable "desired_count" {
  type        = number
  description = "Desired number of running task instances in the ECS service"
  default     = 1
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs where ECS tasks (and the load balancer, if enabled) will run"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs attached to ECS tasks (and the load balancer, if enabled)"
}

variable "enable_alb" {
  type        = bool
  description = "Whether to create and attach an Application Load Balancer to the ECS service"
  default     = true
}

variable "alb_idle_timeout" {
  type        = number
  description = "Application Load Balancer idle timeout in seconds"
  default     = 60
}

variable "cloudwatch_custom_metrics_enabled" {
  type        = bool
  description = "Whether to publish custom CloudWatch metrics for this service"
  default     = false
}

variable "max_monthly_data_out_gb" {
  type        = number
  description = "Expected outbound data transfer per month in GB (used for assumptions and cost awareness)"
  default     = 1
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
  default     = {}
}

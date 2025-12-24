variable "project_id" {
  type        = string
  description = "Azure DevOps project ID where service endpoints will be created"
}

variable "acr_service_endpoint_name" {
  type        = string
  description = "Name of the Azure Container Registry service endpoint"
  default     = "acr-connection"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "acr_resource_group_name" {
  type        = string
  description = "Resource group containing the Azure Container Registry"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID for ACR access"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "github_service_endpoint_name" {
  type        = string
  description = "Name of the GitHub service endpoint"
  default     = "github-connection"
}

variable "github_account_name" {
  type        = string
  description = "GitHub organization or username"
}

variable "github_pat" {
  type        = string
  description = "GitHub Personal Access Token with required scopes"
  sensitive   = true
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to apply across all resources"
  default     = {}
}

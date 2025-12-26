variable "project_name" {
  description = "Name of the Azure DevOps project (AZ-400) labs"
  type        = string
}

variable "project_description" {
  description = "Description of the Azure DevOps project (AZ-400) labs"
  type        = string
  default     = "A project created using Terraform for (AZ-400) labs"
}

variable "visibility" {
  description = "Visibility of the Azure DevOps project (private/public)"
  type        = string
  default     = "private"
}

variable "version_control" {
  description = "The version control system for the project (AZ-400) labs"
  type        = string
  default     = "git"

  validation {
    condition     = contains(["git", "tfvc"], var.version_control)
    error_message = "The version_control must be one of: git or tfvc."
  }
}

variable "work_item_template" {
  description = "The template for Azure DevOps work items (AZ-400) labs"
  type        = string
  default     = "Scrum"

  validation {
    condition     = contains(["Agile", "Scrum", "CMMI"], var.work_item_template)
    error_message = "The work_item_template must be one of: Agile, Scrum, or CMMI."
  }
}

variable "org_service_url" {
  description = "Azure DevOps Organization URL"
  type        = string
}

variable "personal_access_token" {
  description = "Personal Access Token for Azure DevOps"
  type        = string
}

variable "project_id" {
  description = "ID of the Azure DevOps project where the team will be created"
  type        = string
}

variable "team_name" {
  description = "Name of the Production Planning team"
  type        = string
  default     = "Production Plannin"
}

variable "team_description" {
  description = "Description of the Production Planning team's responsibilities"
  type        = string
  default     = "Team responsible for planning production operations and new processes"
}

variable "member_emails" {
  description = "Email addresses of Production Planning team members"
  type        = set(string)
  # default     = []
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags to apply across all Azure DevOps resources"
  type        = map(string)
  default     = {}
}

variable "CostCenter" {
  description = "The cost center associated with the resources"
  type        = string
  default     = "AZ-400-labs"
}

variable "location" {
  description = "Azure region to create the resource group in (az_400) labs"
  type        = string
  default     = "West Europe"
}

variable "project_tags" {
  description = "A map of tags for the Azure DevOps project (az_400) labs"
  type        = map(string)
  default = {
    "Environment" = "AzLab400"
    "Team"        = "AZ-400LabTeam"
    "Release"     = "v1.0.0"
    "Priority"    = "High"
    "SLA"         = "99.9%"
    "Compliance"  = "GDPR"
  }
}

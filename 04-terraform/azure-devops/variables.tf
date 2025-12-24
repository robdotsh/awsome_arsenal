variable "project_name" {
  description = "Name of the Azure DevOps project"
  type        = string
}

variable "project_description" {
  description = "Description of the Azure DevOps project"
  type        = string
  default     = "A project created using Terraform."
}

variable "visibility" {
  description = "Visibility of the Azure DevOps project (private/public)"
  type        = string
  default     = "private"
}

variable "version_control" {
  description = "The version control system for the project"
  type        = string
  default     = "git"

  validation {
    condition     = contains(["git", "tfvc"], var.version_control)
    error_message = "The version_control must be one of: git or tfvc."
  }
}

variable "work_item_template" {
  description = "The template for Azure DevOps work items"
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
  type        = string
  description = "ID of the Azure DevOps project where the team will be created"
}

variable "team_name" {
  type        = string
  description = "Name of the Production Planning team"
  default     = "Production Plannin"
}

variable "team_description" {
  type        = string
  description = "Description of the Production Planning team's responsibilities"
  default     = "Team responsible for planning production operations and new processes"
}

variable "member_emails" {
  type        = set(string)
  description = "Email addresses of Production Planning team members"
  # default     = []
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to apply across all Azure DevOps resources"
  default     = {}
}

variable "CostCenter" {
  type        = string
  description = "The cost center associated with the resources"
  default     = "AZ-400"
}

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
  default     = []
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

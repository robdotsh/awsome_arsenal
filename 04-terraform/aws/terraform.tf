# Terraform and Provider block for AWS

terraform {
  required_version = "1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region

  default_tags {
    tags = merge(
      {
        Environment = var.environment
        Owner       = "DevOps-Tools"
        Service     = "DevOps-Tools"
        CostCenter  = var.CostCenter
        ManagedBy   = "Terraform"
        CreatedBy   = "Terraform"
      },
      var.tags
    )
  }
}

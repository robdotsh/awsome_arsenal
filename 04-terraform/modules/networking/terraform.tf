terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70"
    }
  }

  backend "s3" {
    bucket         = "org-wide-unique-dns-compliant-terraform-state"
    key            = "networking/multi-tier-vpc/prod/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}

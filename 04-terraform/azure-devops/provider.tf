terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 1.12"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = var.org_service_url
  personal_access_token = var.personal_access_token
}

provider "azurerm" {
  features {}

  # Service Principal Authentication
  client_id       = "AZ-400-LAB-CLIENT-ID"
  client_secret   = "AZ-400-LAB-CLIENT-SECRET"
  tenant_id       = "AZ-400-LAB-TENANT-ID"
  subscription_id = "AZ-400-LAB-SUBSCRIPTION-ID"
}

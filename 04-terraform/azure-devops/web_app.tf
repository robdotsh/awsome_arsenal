locals {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "az_400_labs" {
  name     = "az-400-labs-rg"
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = true
  lower   = true
  numeric = true
}

# Create an App Service Plan
resource "azurerm_service_plan" "az_400_labs" {
  name                         = "az-400-labs-service-plan"
  resource_group_name          = azurerm_resource_group.az_400_labs.name
  location                     = azurerm_resource_group.az_400_labs.location
  os_type                      = "Linux"
  sku_name                     = "P1v2"
  maximum_elastic_worker_count = 1
  worker_count                 = 1
  per_site_scaling_enabled     = false
  zone_balancing_enabled       = false
  tags                         = var.tags
}

# Create Web App with a unique name using random string
resource "azurerm_linux_web_app" "az_400_labs" {
  name                = "eshoponWebYAML${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.az_400_labs.name
  location            = azurerm_service_plan.az_400_labs.location
  service_plan_id     = azurerm_service_plan.az_400_labs.id

  site_config {}
}

# output "project_url" {
#   description = "The URL of the Azure DevOps project."
#   value       = azuredevops_project.az_400_labs.web_url
# }

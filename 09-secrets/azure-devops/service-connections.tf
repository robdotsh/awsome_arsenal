resource "azuredevops_serviceendpoint_azurecr" "acr_connection" {
  service_endpoint_name = var.acr_service_endpoint_name
  azure_cr_name         = var.acr_name
  resource_group_name   = var.acr_resource_group_name
  subscription_id       = var.subscription_id
  tenant_id             = var.tenant_id

  project_id = var.project_id

  tags = merge(var.tags, {
    ServiceEndpointType = "AzureContainerRegistry"
    Environment         = var.environment
    ManagedBy           = "TF"
  })
}

resource "azuredevops_serviceendpoint_github" "github_connection" {
  service_endpoint_name = var.github_service_endpoint_name
  personal_access_token = var.github_pat
  account_name          = var.github_account_name
  auth_type             = "token"

  project_id = var.project_id

  tags = merge(var.tags, {
    ServiceEndpointType = "GitHub"
    Environment         = var.environment
    ManagedBy           = "TF"
  })
}

# resource "azuredevops_serviceendpoint_azurecr" "acr_connection" {
#   service_endpoint_name = "my-azurecr-connection"
#   azure_cr_name         = "my-acr"
#   resource_group_name   = "my-resource-group"
#   subscription_id       = "your-subscription-id"
#   tenant_id             = "your-tenant-id"
# }

# resource "azuredevops_serviceendpoint_github" "github_connection" {
#   service_endpoint_name = "github-connection"
#   personal_access_token = var.github_pat
#   account_name          = "your-org"
# }

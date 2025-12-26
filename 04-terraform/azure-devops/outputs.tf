# Azure DevOps project
output "project_id" {
  description = "The ID of the Azure DevOps project."
  value       = azuredevops_project.az_400_labs.id
}

output "project_url" {
  description = "The URL of the Azure DevOps project."
  value       = azuredevops_project.az_400_labs.web_url
}

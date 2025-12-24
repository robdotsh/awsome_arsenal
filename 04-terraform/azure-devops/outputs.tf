# Azure DevOps project
output "project_id" {
  description = "The ID of the Azure DevOps project."
  value       = azuredevops_project.this_project.id
}

# output "project_url" {
#   description = "The URL of the Azure DevOps project."
#   value       = azuredevops_project.this_project.web_url
# }

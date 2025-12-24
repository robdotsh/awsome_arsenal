# resource "azuredevops_git_repository" "robdotsh_app" {
#   project_id = azurerm_devops_project.robdotsh.id
#   name       = "robdotsh-app"
#   initialization {
#     init_type = "Uninitialized"
#   }
# }

# resource "azuredevops_permissions" "repo_permissions" {
#   repository_id = azuredevops_git_repository.robdotsh_app.id
#   principal     = "Production Planning Contributors"
#   permissions   = ["Contribute", "Read"]
#   deny          = ["ForcePush"]
# }

data "azuredevops_group" "az_400_labs_readers" {
  project_id = azuredevops_project.az_400_labs.id
  name       = "Readers"
}

# Manages permissions for a AzureDevOps project
resource "azuredevops_project_permissions" "az_400_labs_permission" {
  project_id = azuredevops_project.az_400_labs.id
  principal  = data.azuredevops_group.az_400_labs_readers.id
  permissions = {
    DELETE              = "Deny"
    EDIT_BUILD_STATUS   = "NotSet"
    WORK_ITEM_MOVE      = "Allow"
    DELETE_TEST_RESULTS = "Deny"
  }
}

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

resource "azuredevops_project" "az_400_labs" {
  name               = var.project_name
  description        = var.project_description
  visibility         = var.visibility
  version_control    = var.version_control
  work_item_template = var.work_item_template

}

# Manages features for Azure DevOps projects
resource "azuredevops_project_features" "az_400_labs_features" {
  project_id = azuredevops_project.az_400_labs.id
  features = {
    testplans = "disabled"
    artifacts = "enabled"
  }
}

resource "azuredevops_project_tags" "az_400_labs" {
  project_id = azuredevops_project.az_400_labs.id
  tags       = [for key, value in var.project_tags : "${key}: ${value}"]
}

# Manages Pipeline Settings for Azure DevOps projects

resource "azuredevops_project_pipeline_settings" "az_400_labs" {
  project_id = azuredevops_project.az_400_labs.id

  enforce_job_scope                    = true
  enforce_referenced_repo_scoped_token = false
  enforce_settable_var                 = true
  publish_pipeline_metadata            = false
  status_badges_are_private            = true
}

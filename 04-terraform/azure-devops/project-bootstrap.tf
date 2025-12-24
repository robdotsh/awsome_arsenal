resource "azuredevops_project" "this_project" {
  name               = var.project_name
  description        = var.project_description
  visibility         = var.visibility
  version_control    = var.version_control
  work_item_template = var.work_item_template

}

# resource "azuredevops_project_tags" "this_project" {
#   project_id = azuredevops_project.this_project.id
#   tags       = ["AZ-400", "AZ-400-DEMO"]
# }

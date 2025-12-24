# Production Planning Team
resource "azuredevops_team" "this_team" {
  project_id  = azuredevops_project.this_project.id
  name        = var.team_name
  description = var.team_description
}

# resource "azuredevops_team_members" "production_planning_members" {
#   project_id = azuredevops_team.this_team.project_id
#   team_id    = azuredevops_team.this_team.id
#   mode       = "overwrite"

#   members = [
#     for email in var.member_emails : email
#   ]
# }

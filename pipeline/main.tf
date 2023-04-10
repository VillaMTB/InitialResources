
data azurerm_client_config current {}

resource "azuredevops_build_definition" "build" {
  project_id = var.project_id
  name       = "05 - Combine Build and Release Pipelines"
  path       = "\\pipelines"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = var.repo_id
    branch_name = var.branch_name
    yml_path    = "pipeline/azdo-pipeline.yml"
  }

  variable {
    name           = "ARM_CLIENT_ID"
    secret_value   = data.azurerm_client_config.current.client_id
    allow_override = false
    is_secret      = true
  }

  variable {
    name           = "ARM_CLIENT_SECRET"
    secret_value   = var.arm_client_secret
    allow_override = false
    is_secret      = true
  }

  variable {
    name           = "ARM_SUBSCRIPTION_ID"
    secret_value   = data.azurerm_client_config.current.subscription_id
    allow_override = false
    is_secret      = true
  }

  variable {
    name           = "ARM_TENANT_ID"
    secret_value   = data.azurerm_client_config.current.tenant_id
    allow_override = false
    is_secret      = true
  }

  variable {
    name           = "TFE_TOKEN"
    secret_value   = var.tfc_token
    allow_override = false
    is_secret      = true
  }

  variable {
    name           = "TFC_ORG"
    secret_value   = var.tfc_org_name
    allow_override = false
    is_secret      = true
  }

}

output "azuredevops_build_definition_build" {
  value      = {}
  depends_on = [azuredevops_build_definition.build]
}

data "azuredevops_users" "all_users" {
  subject_types = ["svc"]
  origin        = "vsts"
  depends_on    = [var.azuredevops_users_depends_on]
}

data "azuredevops_group" "project_contributors" {
  project_id = var.project_id
  name       = "Contributors"
}

data "azuredevops_users" "user" {
  principal_name = element(data.azuredevops_users.all_users.users[*], 
      index(data.azuredevops_users.all_users.users[*].display_name, 
      "${var.project_name} Build Service (${var.org_name})")).principal_name
}

resource "azuredevops_group_membership" "membership" {
  group = data.azuredevops_group.project_contributors.descriptor
  members = [
    element(data.azuredevops_users.user.users[*], 0).descriptor
  ]
}

resource "azuredevops_git_permissions" "project-git-branch-permissions" {
  project_id    = var.project_id
  repository_id = var.repo_id
  branch_name   = "main"
  principal     = data.azuredevops_group.project_contributors.id
  permissions = {
    RemoveOthersLocks = "Allow"
    GenericContribute = "Allow"
  }
}

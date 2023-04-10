/*
	Used to create the Azure DevOps project
*/

data azurerm_client_config current {}

resource "azuredevops_project" "project" {
  name            = var.azure_devops_project
  description     = "Villa MTB initial resources for DevOps and multi-cloud infrastructure"
  visibility      = "private"
  version_control = "Git"
}

resource "azuredevops_serviceendpoint_github" "serviceendpoint_github" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "AzureDevOpsTerraform"
  auth_personal {
    # Also can be set with AZDO_GITHUB_SERVICE_CONNECTION_PAT environment variable
    personal_access_token = var.ado_github_pat
  }
}
data "azuredevops_git_repository" "repo" {
  project_id = azuredevops_project.project.id
  name       = "InitialResources"
}

resource "azuredevops_resource_authorization" "auth" {
  project_id  = azuredevops_project.project.id
  resource_id = azuredevops_serviceendpoint_github.serviceendpoint_github.id
  authorized  = true
}

data "azuredevops_group" "project-contributors" {
  project_id = azuredevops_project.project.id
  name       = "Contributors"
  depends_on = [azuredevops_project.project]
}
/*
resource "azuredevops_git_repository" "repo" {
  project_id = azuredevops_project.project.id
  name       = "GithubInitialResources"
  initialization {
    init_type   = "Import"
    source_type = "Git"
    source_url = "https://github.com/VillaMTB/InitialResources.git"
    service_connection_id = azuredevops_serviceendpoint_github.serviceendpoint_github.id
  }
}*/


resource "azuredevops_git_permissions" "project-git-branch-permissions" {
  project_id    = data.azuredevops_git_repository.repo.project_id
  repository_id = data.azuredevops_git_repository.repo.id
  branch_name   = "main"
  principal     = data.azuredevops_group.project-contributors.id
  permissions = {
    RemoveOthersLocks = "Allow"
    GenericContribute = "Allow"
  }
}
/*
# Load a specific Git repository by name
data "azuredevops_git_repository" "repo" {
  project_id = azuredevops_project.project.id
  name       = var.azure_devops_repo
  depends_on = [azuredevops_git_repository.repo]
}*/

resource "azuredevops_serviceendpoint_azurerm" "endpointazure" {
  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "HashiCorp SE AzureRM"
  description               = "Managed by Terraform"
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name = "Personal Development"
}


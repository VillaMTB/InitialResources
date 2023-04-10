module "project" {
  source               = "./project"
  azure_devops_project = var.azure_devops_project_name
  azure_devops_repo    = var.azure_devops_repo_name
  ado_github_pat       = var.ado_github_pat
}
/*
module "pipeline" {
  source            = "./pipeline"
  project_id        = module.project.azuredevops_project_project_id
  repo_id           = module.project.azuredevops_project_repo_id
  branch_name       = module.project.azuredevops_project_repo_default_branch
  project_name      = var.azure_devops_project_name
  repo_name         = var.azure_devops_repo_name
  org_name          = var.organization_name
  arm_client_secret = var.arm_client_secret
  tfc_org_name      = var.organization_name
  tfc_token         = var.tfc_token

  azuredevops_users_depends_on = [
    module.project.azuredevops_git_repository_repo,
    module.pipeline5.azuredevops_build_definition_build
  ]
}
*/

output "azuredevops_project_project_id" {
  value = azuredevops_project.project.id
}
/*
output "azuredevops_project_repo_url" {
  value       = data.azuredevops_git_repository.repo.web_url
  description = "The private IP address of the main server instance"
}

output "azuredevops_project_repo_default_branch" {
  value       = data.azuredevops_git_repository.repo.default_branch
  description = "default_branch"
}
output "azuredevops_project_repo_id" {
  value = azuredevops_git_repository.repo.id
}

output "azuredevops_git_repository_repo" {
  value      = {}
  depends_on = [azuredevops_git_repository.repo]
}
*/
variable "azure_devops_project_name" {
  type        = string
  description = "The name for the Azure DevOps project"
  default     = "InitialResources"
}
variable "azure_devops_repo_name" {
  type        = string
  description = "The name for the Azure DevOps repository after it is mirrored"
  default     = "starter-pipeline"
}
variable "organization_name" {
  type        = string
  description = "The name of the organization used for Azure, OCI, DevOps, Terraform Cloud"
  default     = "VillaMTB"
}
variable "ado_github_pat" {}
variable "arm_client_secret" {}
variable "tfc_token" {}

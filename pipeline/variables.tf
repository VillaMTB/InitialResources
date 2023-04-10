variable "tfc_org_name" {}
variable "project_name" {}
variable "repo_name" {}
variable "org_name" {}
variable "azuredevops_users_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

variable "arm_client_secret" {}
variable "project_id" {}
variable "repo_id" {}
variable "branch_name" {}
variable "tfc_token" {}
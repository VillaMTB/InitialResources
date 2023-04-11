# Azure subscription
variable "az_location" {
  type    = string
  default = "ukwest"
}

#GitHub
variable "ado_github_pat" {
  type        = string
  description = "Personal authentication token for GitHub repo"
  sensitive   = true
}

# Organization
variable "organization_name" {
  type        = string
  description = "The organization name in Terraform Cloud, Azure DevOps and the OCI compartment name"
  default     = "VillaMTB"
}

locals {
  ado_org_service_url     = "https://dev.azure.com/${var.organization_name}"
  ado_project_description = "Creates initial resources in all cloud providers"
  ado_project_name        = "InitialResources"
}
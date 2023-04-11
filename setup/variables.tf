# Azure subscription
variable "az_client_id" {
  type        = string
  description = "Client ID with permissions to create resources in Azure, use env variables"
}
variable "az_client_secret" {
  type        = string
  description = "Client secret with permissions to create resources in Azure, use env variables"
}
variable "az_container_name" {
  type        = string
  description = "Name of container on storage account for Terraform state"
  default     = "terraform-state"
}
variable "az_location" {
  type    = string
  default = "ukwest"
}
variable "az_state_key" {
  type        = string
  description = "Name of key in storage account for Terraform state"
  default     = "terraform.tfstate"
}
variable "az_subscription" {
  type        = string
  description = "Client ID subscription, use env variables"
}
variable "az_tenant" {
  type        = string
  description = "Client ID Azure AD tenant, use env variables"
}

#GitHub
variable "ado_github_pat" {
  type        = string
  description = "Personal authentication token for GitHub repo"
  sensitive   = true
}

# Organization
variable "notification_email_address" {
  type = string
  description = "Email address where pipeline notifications will be sent"
  default = "davidyates31@outlook.com"
}
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
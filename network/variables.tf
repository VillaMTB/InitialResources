variable "az_location" {
  type        = string
  description = "Region in Azure"
  default     = "ukwest"
}
variable "org_cidr_block" {}
variable "organization_name" {}

locals {
  az_cidr_block       = cidrsubnet(var.org_cidr_block, 8, 1)
  ado_org_service_url = "https://dev.azure.com/${var.organization_name}"
}

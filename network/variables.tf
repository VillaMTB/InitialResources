variable "az_region" {
  type        = string
  description = "Region in Azure"
  default     = "ukwest"
}
variable "org_cidr_block" {
  default = "10.0.0.0/8"
}
variable "organization_name" {
  default = "VillaMTB"
}

locals {
  az_cidr_block       = cidrsubnet(var.org_cidr_block, 8, 1)
  ado_org_service_url = "https://dev.azure.com/${var.organization_name}"
}

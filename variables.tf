# Azure RM
variable "az_region" {
  type        = string
  description = "Region in Azure"
  default     = "ukwest"
}
# OCI
variable "oci_fingerprint" {}
variable "oci_private_key" {}
variable "oci_region" {}
variable "org_compartment_ocid" {
  default = "ocid1.compartment.oc1..aaaaaaaaltmnotnr7v4umg5wjng3477abn5qbmhzgmsidapj3ffutjd4xcda"
}
variable "tenancy_ocid" {}
variable "user_ocid" {}

# Organization
variable "org_cidr_block" {
  default = "10.0.0.0/8"
}
variable "organization_name" {
  default = "VillaMTB"
}

locals {
  ado_org_service_url = "https://dev.azure.com/${var.organization_name}"
  az_cidr_block       = cidrsubnet(var.org_cidr_block, 8, 1)
  oci_cidr_block      = cidrsubnet(var.org_cidr_block, 8, 0)
}

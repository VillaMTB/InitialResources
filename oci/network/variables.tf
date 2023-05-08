variable "az_cidr_block" {}
variable "environment_code" {}
variable "onprem_cidr_block" {}
variable "org_cidr_block" {}
variable "organization_name" {}
variable "tenancy_ocid" {}

locals {
  org_compartment_ocid = data.oci_identity_compartments.OrganizationCompartments.id
}
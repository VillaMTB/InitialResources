module "az-network" {
  source            = "./network/az-network"
  az_region         = var.az_region
  organization_name = var.organization_name
}

module "oci-network" {
  source               = "./network/oci-network"
  az_cidr_block        = cidrsubnet(cidrsubnet(var.org_cidr_block, 8, 0), 8, 1)
  environment_code     = "Corp"
  onprem_cidr_block    = cidrsubnet(cidrsubnet(var.org_cidr_block, 8, 0), 8, 5)
  org_cidr_block       = var.org_cidr_block
  org_compartment_ocid = var.org_compartment_ocid
  organization_name    = var.organization_name
}


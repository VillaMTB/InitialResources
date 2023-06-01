/*module "az-network" {
  source            = "./azurerm/network"
  az_region         = var.az_region
  organization_name = var.organization_name
}
*/
module "oci-network" {
  source            = "./oci/network"
  az_cidr_block     = cidrsubnet(cidrsubnet(var.org_cidr_block, 8, 0), 8, 1)
  environment_code  = "Corp"
  onprem_cidr_block = cidrsubnet(cidrsubnet(var.org_cidr_block, 8, 0), 8, 5)
  org_cidr_block    = var.org_cidr_block
  organization_name = var.organization_name
  tenancy_ocid      = var.tenancy_ocid
}

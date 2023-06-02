/*module "az-network" {
  source            = "./azurerm/network"
  az_region         = var.az_region
  organization_name = var.organization_name
}
*/

data "oci_identity_compartments" "org_compartments" {
  #Required
  compartment_id = var.tenancy_ocid
  #Optional
  name = var.organization_name
}

data "oci_identity_availability_domains" "org_availability_domains" {
  #Required
  compartment_id = var.tenancy_ocid
}

module "oci-network" {
  source               = "./oci/network"
  az_cidr_block        = cidrsubnet(cidrsubnet(var.org_cidr_block, 8, 1), 8, 0)
  environment_code     = "Corp"
  home_ip_address      = "2.25.217.51"
  onprem_cidr_block    = cidrsubnet(var.org_cidr_block, 8, 5)
  org_cidr_block       = var.org_cidr_block
  org_compartment_ocid = local.org_compartment_ocid
  organization_name    = var.organization_name
}

module "oci-corp-filesys" {
  source                  = "./oci/storage"
  corp_subnet_id          = module.oci-network.corp_subnet_id
  oci_availability_domain = data.oci_identity_availability_domains.org_availability_domains.availability_domains[0].name
  org_compartment_ocid    = local.org_compartment_ocid
  organization_domain     = "${lower(var.organization_name)}.com"
  tenancy_namespace       = var.tenancy_namespace
}

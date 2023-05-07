module "az-network" {
	source = "./network/az-network"
	az_region = var.az_region
	organization_name = var.organization_name
}
module "oci-network" {
	source = "./network/oci-network"
	environment_code = "Corp"
	org_cidr_block = var.org_cidr_block
	org_compartment_ocid = var.tenancy_ocid
	organization_name = var.organization_name
}

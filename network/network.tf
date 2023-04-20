
module "az-network" {
  source              = "Azure/network/azurerm"
  version             = "3.1.1"
  resource_group_name = "${var.organization_name}RSG"
  vnet_name           = "${var.organization_name}VNet"
  address_space       = local.az_cidr_block
  subnet_prefixes     = [cidrsubnet(local.az_cidr_block, 8, 0)]
  subnet_names        = ["corp"]
}

# Main VCN
data "oci_identity_compartments" "ociCompartments" {
  #Required
  compartment_id = var.tenancy_ocid
  filter {
    name   = "displayName"
    values = [var.organization_name]
    regex  = false
  }
}

resource "oci_core_vcn" "ociCorpVCN" {
  compartment_id = data.oci_identity_compartments.ociCompartments.id
  cidr_blocks    = [cidrsubnet(local.oci_cidr_block, 8, 0)]
  display_name   = join("-", [var.organization_name, "Corp", "VCN"])
  dns_label      = "villamtb"
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}
/*
# Main VCN
resource "oci_core_vcn" "ociVillaMTBCorpVCN" {
  compartment_id = var.org_compartment_ocid
  cidr_blocks    = [cidrsubnet(var.org_cidr_block, 8, 0)]
  display_name   = join("-", [var.organization_name, var.environment_code, "VCN"])
  dns_label      = "villamtb"
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}

#	Subnet
resource "oci_core_subnet" "ociVillaMTBCorpSubnet" {
  compartment_id             = var.org_compartment_ocid
  vcn_id                     = oci_core_vcn.ociVillaMTBCorpVCN.id
  cidr_block                 = cidrsubnet(cidrsubnet(var.org_cidr_block, 8, 0), 8, 1)
  display_name               = join("-", [var.organization_name, var.environment_code, "Subnet"])
  dns_label                  = lower(var.environment_code)
  route_table_id             = oci_core_vcn.ociVillaMTBCorpVCN.default_route_table_id
  security_list_ids          = [oci_core_vcn.ociVillaMTBCorpVCN.default_security_list_id]
  prohibit_public_ip_on_vnic = true
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}

#	Services
data "oci_core_services" "ociVillaMTBCorpServices" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

#	NAT gateway
resource "oci_core_nat_gateway" "ociVillaMTBCorpNAT" {
  #Required
  compartment_id = var.org_compartment_ocid
  display_name   = join("-", [var.organization_name, var.environment_code, "NAT"])
  vcn_id         = oci_core_vcn.ociVillaMTBCorpVCN.id
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}

# Default Route Table
resource "oci_core_default_route_table" "ociVillaMTBCorpDefaultRT" {
  manage_default_resource_id = oci_core_vcn.ociVillaMTBCorpVCN.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.ociVillaMTBCorpNAT.id
  }
  route_rules {
    destination       = data.oci_core_services.ociVillaMTBCorpServices.services[0]["cidr_block"]
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.ociVillaMTBCorpSVC.id
  } 
  route_rules {
    destination       = var.onprem_cidr_block
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.ociVillaMTBDRG.id
  }
  route_rules {
    destination       = var.az_cidr_block
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.ociVillaMTBDRG.id
  }
}

#	Service gateway
resource "oci_core_service_gateway" "ociVillaMTBCorpSVC" {
  #Required
  compartment_id = var.org_compartment_ocid
  display_name   = join("-", [var.organization_name, var.environment_code, "SVCGwy"])
  vcn_id         = oci_core_vcn.ociVillaMTBCorpVCN.id

  services {
    service_id = data.oci_core_services.ociVillaMTBCorpServices.services[0]["id"]
  }
}

# DRG
resource "oci_core_drg" "ociVillaMTBDRG" {
  #Required
  compartment_id = var.org_compartment_ocid

  #Optional
  display_name = join("-", [var.organization_name, var.environment_code, "DRG"])
}

# DRG attachment
resource "oci_core_drg_attachment" "ociVillaMTBCorpDRGAttach" {
  #Required
  drg_id       = oci_core_drg.ociVillaMTBDRG.id
  display_name = join("-", [var.organization_name, var.environment_code, "DRGAttach"])
  # Optional
  network_details {
    id   = oci_core_vcn.ociVillaMTBCorpVCN.id
    type = "VCN"
  }
}
*/

# Main VCN
resource "oci_core_vcn" "ociVillaMTBVCN" {
  compartment_id = var.org_compartment_ocid
  cidr_blocks    = [cidrsubnet(var.org_cidr_block, 8, 0)]
  display_name   = join("-", [var.organization_name, "Corp", "VCN"])
  dns_label      = local.dns
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}

#	Subnets
resource "oci_core_subnet" "ociVillaMTBCorpSubnet" {
  compartment_id             = var.org_compartment_ocid
  vcn_id                     = oci_core_vcn.ociVillaMTBVCN.id
  cidr_block                 = cidrsubnet(cidrsubnet(var.org_cidr_block, 8, 0), 8, 0)
  dhcp_options_id            = oci_core_dhcp_options.ociVillaMTBCorpDHCP.id
  display_name               = join("-", [var.organization_name, "Corp", "Subnet"])
  dns_label                  = lower("Corp")
  route_table_id             = oci_core_vcn.ociVillaMTBVCN.default_route_table_id
  security_list_ids          = [oci_core_vcn.ociVillaMTBVCN.default_security_list_id]
  prohibit_public_ip_on_vnic = true
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}

# DHCP Options using custom on-premise resolvers
resource "oci_core_dhcp_options" "ociVillaMTBCorpDHCP" {
  #Required
  compartment_id = var.org_compartment_ocid
  display_name   = join("-", [var.organization_name, "Corp", "DHCP"])
  options {
    type               = "DomainNameServer"
    server_type        = "CustomDnsServer"
    custom_dns_servers = ["10.5.0.2", "10.5.0.1"]
  }

  options {
    type                = "SearchDomain"
    search_domain_names = [local.domain]
  }

  vcn_id = oci_core_vcn.ociVillaMTBVCN.id
}

#	Services
data "oci_core_services" "ociVillaMTBServices" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

#	NAT gateway
resource "oci_core_nat_gateway" "ociVillaMTBNAT" {
  #Required
  compartment_id = var.org_compartment_ocid
  display_name   = join("-", [var.organization_name, "Corp", "NAT"])
  vcn_id         = oci_core_vcn.ociVillaMTBVCN.id
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}

# Default Route Table
resource "oci_core_default_route_table" "ociVillaMTBDefaultRT" {
  manage_default_resource_id = oci_core_vcn.ociVillaMTBVCN.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.ociVillaMTBNAT.id
  }
  route_rules {
    destination       = data.oci_core_services.ociVillaMTBServices.services[0]["cidr_block"]
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.ociVillaMTBSVC.id
  }
  route_rules {
    destination       = var.onprem_cidr_block
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.ociVillaMTBDRG.id
  }
  /*  route_rules {
    destination       = var.az_cidr_block
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.ociVillaMTBDRG.id
  }*/
}

#	Service gateway
resource "oci_core_service_gateway" "ociVillaMTBSVC" {
  #Required
  compartment_id = var.org_compartment_ocid
  display_name   = join("-", [var.organization_name, "Corp", "SVCGwy"])
  vcn_id         = oci_core_vcn.ociVillaMTBVCN.id

  services {
    service_id = data.oci_core_services.ociVillaMTBServices.services[0]["id"]
  }
}

# DRG
resource "oci_core_drg" "ociVillaMTBDRG" {
  #Required
  compartment_id = var.org_compartment_ocid

  #Optional
  display_name = join("-", [var.organization_name, "Corp", "DRG"])
}

# DRG attachment
resource "oci_core_drg_attachment" "ociVillaMTBDRGAttach" {
  #Required
  drg_id       = oci_core_drg.ociVillaMTBDRG.id
  display_name = join("-", [var.organization_name, "Corp", "DRGAttach"])
  # Optional
  network_details {
    id   = oci_core_vcn.ociVillaMTBVCN.id
    type = "VCN"
  }
}

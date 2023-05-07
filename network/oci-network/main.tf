# Main VCN
resource "oci_core_vcn" "ociVillaMTBCorpVCN" {
  compartment_id = var.org_compartment_ocid
  cidr_blocks    = [cidrsubnet(var.org_cidr_block, 8, 0)]
  display_name   = join("-", [var.organization_name, var.environment_code, "VCN"])
  dns_label      = "villamtb"
  # defined_tags = {"Operations.CostCentre"= "1","Oracle-Tags.CreatedBy"="david","Oracle-Tags.CreatedOn"=timestamp()}
}
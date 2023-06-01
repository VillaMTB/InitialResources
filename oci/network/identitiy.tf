#	Compartments
data "oci_identity_compartments" "org_compartments" {
  #Required
  compartment_id = var.tenancy_ocid
  name           = var.organization_name
}

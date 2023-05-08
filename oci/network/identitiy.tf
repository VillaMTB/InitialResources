#	Compartments
data "oci_identity_compartments" "OrganizationCompartments" {
  #Required
  compartment_id = var.tenancy_ocid
  filter {
    name   = "name"
    values = [var.organization_name]
    regex  = false
  }
}

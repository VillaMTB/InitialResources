resource "oci_objectstorage_bucket" "binaries_bucket" {
  #Required
  compartment_id = var.org_compartment_ocid
  name           = "binaries"
  namespace      = var.tenancy_namespace

  #Optional
  auto_tiering = "InfrequentAccess"
}
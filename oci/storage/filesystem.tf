resource "oci_file_storage_mount_target" "ociVillaMTBCorpMT" {
  #Required
  availability_domain = var.oci_availability_domain
  compartment_id      = var.org_compartment_ocid
  subnet_id           = var.corp_subnet_id

  #Optional
  # defined_tags   = { "Operations.CostCentre" = "1", "Oracle-Tags.CreatedBy" = "david", "Oracle-Tags.CreatedOn" = timestamp() }
  display_name   = "corpdata"
  freeform_tags  = { "Department" = "Operations" }
  hostname_label = "corpdata"
}
resource "oci_file_storage_file_system" "ociVillaMTBExtractsFS" {
  #Required
  availability_domain = var.oci_availability_domain
  compartment_id      = var.org_compartment_ocid

  #Optional
  # defined_tags  = { "Operations.CostCentre" = "1", "Oracle-Tags.CreatedBy" = "david", "Oracle-Tags.CreatedOn" = timestamp() }
  display_name  = "Extracts"
  freeform_tags = { "Department" = "Operations" }
}
resource "oci_file_storage_export_set" "ociVillaMTBCorpDataExportSet" {
  #Required
  mount_target_id = oci_file_storage_mount_target.ociVillaMTBCorpMT.id

  #Optional
  display_name = "Corpdata Export Set"
  # max_fs_stat_bytes = 23843202333
  # max_fs_stat_files = 223442
}
resource "oci_file_storage_export" "extracts_export" {
  #Required
  export_set_id  = oci_file_storage_export_set.ociVillaMTBCorpDataExportSet.id
  file_system_id = oci_file_storage_file_system.ociVillaMTBExtractsFS.id
  path           = "/extracts"
}
resource "oci_file_storage_file_system" "ociVillaMTBCorpFS" {
  #Required
  availability_domain = var.oci_availability_domain
  compartment_id      = var.org_compartment_ocid

  #Optional
  # defined_tags  = { "Operations.CostCentre" = "1", "Oracle-Tags.CreatedBy" = "david", "Oracle-Tags.CreatedOn" = timestamp() }
  display_name  = "Corp"
  freeform_tags = { "Department" = "Operations" }
}
resource "oci_file_storage_export" "corp_export" {
  #Required
  export_set_id  = oci_file_storage_export_set.ociVillaMTBCorpDataExportSet.id
  file_system_id = oci_file_storage_file_system.ociVillaMTBCorpFS.id
  path           = "/corp"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    oci = {
      source = "hashicorp/oci"
    }
  }
  backend "azurerm" {

  }
}

provider "azurerm" {
  features {}
}
provider "oci" {
  region       = var.oci_region
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  fingerprint  = var.oci_fingerprint
  private_key  = var.oci_private_key
}

data "azurerm_client_config" "current" {}

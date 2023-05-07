terraform {
  cloud {
    organization = "VillaMTB"
    workspaces {
      name = "InitialResources"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"

    }
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "oci" {
  fingerprint  = var.oci_fingerprint
  private_key  = var.oci_private_key
  region       = var.oci_region
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
}
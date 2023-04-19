terraform {
  cloud {
    organization = "VillaMTB"
    workspaces {
      name = "InitialResources"
    }
  }
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"

    }
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "azuredevops" {
  org_service_url = local.ado_org_service_url
  # Authentication through PAT defined with AZDO_PERSONAL_ACCESS_TOKEN 
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
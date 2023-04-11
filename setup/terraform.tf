terraform {
  cloud {
    organization = "VillaMTB"
    workspaces {
      name = "Azure-DevOps-Setup"
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
  }
}

provider "azuredevops" {
  org_service_url = local.ado_org_service_url
  # Authentication through PAT defined with AZDO_PERSONAL_ACCESS_TOKEN 
}
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

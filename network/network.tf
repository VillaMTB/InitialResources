module "az-network" {
  source              = "Azure/network/azurerm"
  version             = "3.1.1"
  resource_group_name = "${var.organization_name}RSG"
  vnet_name           = "${var.organization_name}VNet"
  address_space       = local.az_cidr_block
  subnet_prefixes     = [cidrsubnet(local.az_cidr_block, 8, 0)]
  subnet_names        = ["corp"]
}

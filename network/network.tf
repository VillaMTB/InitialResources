module "network" {
  source              = "Azure/network/azurerm"
  version             = "3.1.1"
  resource_group_name = "${var.organization_name}RG"
  vnet_name           = "${var.org_cidr_block}VNet"
  address_space       = local.az_cidr_block
  subnet_prefixes     = [cidrsubnet(local.az_cidr_block, 8, 0)]
  subnet_names        = ["corp"]
}

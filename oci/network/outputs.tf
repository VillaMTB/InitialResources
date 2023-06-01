output "home-vpn-tunnels" {
  value = data.oci_core_ipsec_connection_tunnels.homeIPSecTunnels
}
output "corp_subnet_id" {
  value = oci_core_subnet.ociVillaMTBCorpSubnet.id
}
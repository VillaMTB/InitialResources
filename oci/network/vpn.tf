resource "oci_core_cpe" "homeCPE" {
  #Required
  compartment_id = var.org_compartment_ocid
  ip_address     = var.home_ip_address

  #Optional
  display_name = "HomeRouter"
}


resource "oci_core_ipsec" "homeIPSec" {
  #Required
  compartment_id = var.org_compartment_ocid
  cpe_id         = oci_core_cpe.homeCPE.id
  drg_id         = oci_core_drg.ociVillaMTBDRG.id
  static_routes  = [var.onprem_cidr_block]
  #Optional
  cpe_local_identifier      = var.home_ip_address
  cpe_local_identifier_type = "IP_ADDRESS"
  display_name              = "HomeIPSecConnection"
}
data "oci_core_ipsec_connections" "homeIPSecs" {
  #Required
  compartment_id = var.org_compartment_ocid

  #Optional
  cpe_id = oci_core_cpe.homeCPE.id
  drg_id = oci_core_drg.ociVillaMTBDRG.id
}

data "oci_core_ipsec_connection_tunnels" "homeIPSecTunnels" {
  #Required
  ipsec_id = oci_core_ipsec.homeIPSec.id
}

resource "oci_core_ipsec_connection_tunnel_management" "homeIPSecTunnelMgmt" {
  count = 2
  #Required
  ipsec_id     = oci_core_ipsec.homeIPSec.id
  tunnel_id    = data.oci_core_ipsec_connection_tunnels.homeIPSecTunnels.ip_sec_connection_tunnels[count.index].id
  routing      = "STATIC"
  display_name = "Home Tunnel ${count.index}"
}
data "oci_core_ipsec_connection_tunnel_routes" "homeIPSecTunnelRoute" {
  count = 2
  #Required
  ipsec_id  = oci_core_ipsec.homeIPSec.id
  tunnel_id = data.oci_core_ipsec_connection_tunnels.homeIPSecTunnels.ip_sec_connection_tunnels[count.index].id

}

resource "oci_dns_view" "ociVillaMTBPrivateView" {
  #Required
  compartment_id = var.org_compartment_ocid

  #Optional
  scope        = "PRIVATE"
  display_name = "${lower(var.organization_name)}.com"
}
resource "oci_dns_zone" "ociVillaMTBPrivateZone" {
  #Required
  compartment_id = var.org_compartment_ocid
  name           = "${lower(var.organization_name)}.com"
  zone_type      = "PRIMARY"
  #Optional
  scope   = "PRIVATE"
  view_id = oci_dns_view.ociVillaMTBPrivateView.id
}
resource "oci_dns_rrset" "ociVillaMTBDC1" {
  #Required
  domain          = "dc1.${lower(var.organization_name)}.com"
  rtype           = "A"
  zone_name_or_id = oci_dns_zone.ociVillaMTBPrivateZone.id

  #Optional
  compartment_id = var.org_compartment_ocid
  items {
    #Required
    domain = "dc1.${lower(var.organization_name)}.com"
    rdata  = "10.5.0.2"
    rtype  = "A"
    ttl    = "30"
  }
  scope   = "PRIVATE"
  view_id = oci_dns_view.ociVillaMTBPrivateView.id
}

resource "oci_dns_rrset" "ociVillaMTBFW" {
  #Required
  domain          = "firewall.${lower(var.organization_name)}.com"
  rtype           = "A"
  zone_name_or_id = oci_dns_zone.ociVillaMTBPrivateZone.id

  #Optional
  compartment_id = var.org_compartment_ocid
  items {
    #Required
    domain = "firewall.${lower(var.organization_name)}.com"
    rdata  = "10.5.0.1"
    rtype  = "A"
    ttl    = "30"
  }
  scope   = "PRIVATE"
  view_id = oci_dns_view.ociVillaMTBPrivateView.id
}
# Create DNS listener and forwarder with a rule to the On-Premise DNS server
data "oci_dns_resolvers" "ociVillaMTBDNSResolvers" {
  #Required
  compartment_id = var.org_compartment_ocid
  scope          = "PRIVATE"

  #Optional
  display_name = join("-", [var.organization_name, "Corp", "VCN"])
}
resource "oci_dns_resolver_endpoint" "ociVillaMTBCorpDNSForwarder" {
  #Required
  is_forwarding = true
  is_listening  = false
  name          = join("", [var.organization_name, "Forwarder"])
  resolver_id   = data.oci_dns_resolvers.ociVillaMTBDNSResolvers.resolvers[0].id
  subnet_id     = oci_core_subnet.ociVillaMTBCorpSubnet.id
  scope         = "PRIVATE"
}
resource "oci_dns_resolver_endpoint" "ociVillaMTBCorpDNSListener" {
  #Required
  is_forwarding = false
  is_listening  = true
  name          = join("", [var.organization_name, "Listener"])
  resolver_id   = data.oci_dns_resolvers.ociVillaMTBDNSResolvers.resolvers[0].id
  subnet_id     = oci_core_subnet.ociVillaMTBCorpSubnet.id
  scope         = "PRIVATE"
}

resource "oci_dns_resolver" "ociVillaMTBDNSResolver" {
  #Required
  resolver_id = data.oci_dns_resolvers.ociVillaMTBDNSResolvers.resolvers[0].id

  #Optional
  scope = "PRIVATE"
  attached_views {
    #Required
    view_id = oci_dns_view.ociVillaMTBPrivateView.id
  }
  rules {
    #Required
    action                = "FORWARD"
    destination_addresses = ["10.5.0.2"]
    source_endpoint_name  = oci_dns_resolver_endpoint.ociVillaMTBCorpDNSForwarder.name
    #Optional
    qname_cover_conditions = ["${lower(var.organization_name)}.com"]
  }
}
# Associate the private view to the VCN DNS resolver

# Default Security List for the VCN

resource "oci_core_default_security_list" "ociVillaMTBDSL" {
  manage_default_resource_id = oci_core_vcn.ociVillaMTBVCN.default_security_list_id
  compartment_id             = var.org_compartment_ocid
  # defined_tags = (local.common_tags)

  egress_security_rules {
    #Required
    destination = "0.0.0.0/0"
    protocol    = "all"

    #Optional
    destination_type = "CIDR_BLOCK"
  }
  ingress_security_rules {
    protocol = 1
    source   = "0.0.0.0/0"
    icmp_options {
      type = 3
      code = 4
    }
  }
  ingress_security_rules {
    protocol = 1
    source   = oci_core_vcn.ociVillaMTBVCN.cidr_block
    icmp_options {
      type = 3
    }
  }
  ingress_security_rules {
    description = "ICMP Ping VCN"
    protocol    = 1
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block
  }
  ingress_security_rules {
    description = "ICMP Ping On Premise"
    protocol    = 1
    source      = var.onprem_cidr_block
  }
  ingress_security_rules {
    description = "ICMP Ping Azure VNet"
    protocol    = 1
    source      = var.az_cidr_block
  }

  ingress_security_rules {
    description = "SSH All"
    protocol    = "6"
    source      = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    description = "HTTP"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    description = "HTTP"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    description = "HTTPS"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    description = "HTTPS"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    description = "DNS On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 53
      max = 53
    }
  }

  ingress_security_rules {
    description = "DNS On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 53
      max = 53
    }
  }

  ingress_security_rules {
    description = "DNS VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 53
      max = 53
    }
  }

  ingress_security_rules {
    description = "DNS VCN"
    protocol    = "17"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    udp_options {
      min = 53
      max = 53
    }
  }

  ingress_security_rules {
    description = "Kerberos On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 88
      max = 88
    }
  }

  ingress_security_rules {
    description = "Kerberos On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 88
      max = 88
    }
  }

  ingress_security_rules {
    description = "Kerberos VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 88
      max = 88
    }
  }

  ingress_security_rules {
    description = "Kerberos VCN"
    protocol    = "17"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    udp_options {
      min = 88
      max = 88
    }
  }
  ingress_security_rules {
    description = "File System On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 111
      max = 111
    }
  }
  ingress_security_rules {
    description = "File System VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 111
      max = 111
    }
  }
  ingress_security_rules {
    description = "File System On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 111
      max = 111
    }
  }
  ingress_security_rules {
    description = "File System VCN"
    protocol    = "17"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    udp_options {
      min = 111
      max = 111
    }
  }
  ingress_security_rules {
    description = "Kerberos On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 464
      max = 464
    }
  }

  ingress_security_rules {
    description = "Kerberos On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 464
      max = 464
    }
  }

  ingress_security_rules {
    description = "Kerberos VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 464
      max = 464
    }
  }

  ingress_security_rules {
    description = "Kerberos VCN"
    protocol    = "17"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    udp_options {
      min = 464
      max = 464
    }
  }

  ingress_security_rules {
    description = "NTP On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 123
      max = 123
    }
  }

  ingress_security_rules {
    description = "NTP VCN"
    protocol    = "17"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    udp_options {
      min = 123
      max = 123
    }
  }

  ingress_security_rules {
    description = "SMB On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 137
      max = 138
    }
  }

  ingress_security_rules {
    description = "SMB On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 139
      max = 139
    }
  }

  ingress_security_rules {
    description = "SMB On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 445
      max = 445
    }
  }
  ingress_security_rules {
    description = "SMB VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 445
      max = 445
    }
  }
  ingress_security_rules {
    description = "LDAP On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 389
      max = 389
    }
  }

  ingress_security_rules {
    description = "LDAP On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 389
      max = 389
    }
  }

  ingress_security_rules {
    description = "LDAP VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 389
      max = 389
    }
  }
  ingress_security_rules {
    description = "LDAP VCN"
    protocol    = "17"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    udp_options {
      min = 389
      max = 389
    }
  }
  ingress_security_rules {
    description = "File System On Premise"
    protocol    = "17"
    source      = var.onprem_cidr_block

    udp_options {
      min = 2048
      max = 2048
    }
  }
  ingress_security_rules {
    description = "File System VCN"
    protocol    = "17"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    udp_options {
      min = 2048
      max = 2048
    }
  }
  ingress_security_rules {
    description = "File System On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 2048
      max = 2050
    }
  }
  ingress_security_rules {
    description = "File System VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 2048
      max = 2050
    }
  }
  ingress_security_rules {
    description = "LDAP Global Catalog On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 3268
      max = 3268
    }
  }

  ingress_security_rules {
    description = "LDAP Global Catalog VCN"
    protocol    = "6"
    source      = oci_core_vcn.ociVillaMTBVCN.cidr_block

    tcp_options {
      min = 3268
      max = 3268
    }
  }

  ingress_security_rules {
    description = "Windows RDP On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 3389
      max = 3389
    }
  }

  ingress_security_rules {
    description = "VNC On Premise"
    protocol    = "6"
    source      = var.onprem_cidr_block

    tcp_options {
      min = 5901
      max = 5902
    }
  }
}

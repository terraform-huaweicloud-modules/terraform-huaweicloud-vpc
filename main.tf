######################################################################
# Default VPC
######################################################################

resource "huaweicloud_vpc" "this" {
  count = var.is_vpc_create ? 1 : 0

  name            = var.vpc_name
  cidr            = var.vpc_cidr
  description     = var.vpc_description != "" ? var.vpc_description : null
  secondary_cidrs = length(var.vpc_secondary_cidrs) > 0 ? var.vpc_secondary_cidrs : null
  tags            = length(var.vpc_tags) > 0 ? var.vpc_tags : null

  enterprise_project_id = var.enterprise_project_id != "" ? var.enterprise_project_id : null

  lifecycle {
    precondition {
      condition     = (var.vpc_name != "" && var.vpc_name != null) && (var.vpc_cidr != "" && var.vpc_cidr != null)
      error_message = "Field 'vpc_name' and field 'vpc_cidr' are required."
    }
  }
}

data "huaweicloud_vpcs" "this" {
  count = length(var.query_vpc_names) > 0 ? 1 : 0
}

######################################################################
# All subnets under VPC resource
######################################################################

resource "huaweicloud_vpc_subnet" "this" {
  count = var.is_vpc_create ? length(var.subnets_configuration) : 0

  vpc_id = huaweicloud_vpc.this[0].id

  name        = lookup(element(var.subnets_configuration, count.index), "name")
  cidr        = lookup(element(var.subnets_configuration, count.index), "cidr")
  gateway_ip  = lookup(element(var.subnets_configuration, count.index), "gateway_ip") != "" ? lookup(element(var.subnets_configuration, count.index), "gateway_ip") : cidrhost(lookup(element(var.subnets_configuration, count.index), "cidr"), 1)
  description = lookup(element(var.subnets_configuration, count.index), "description") != "" ? lookup(element(var.subnets_configuration, count.index), "description") : null
  ipv6_enable = lookup(element(var.subnets_configuration, count.index), "ipv6_enabled")
  dhcp_enable = lookup(element(var.subnets_configuration, count.index), "dhcp_enabled")
  dns_list    = try(length(lookup(element(var.subnets_configuration, count.index), "dns_list")), 0) > 0 ? lookup(element(var.subnets_configuration, count.index), "dns_list") : null

  tags = try(length(lookup(element(var.subnets_configuration, count.index), "tags")), 0) > 0 ? lookup(element(var.subnets_configuration, count.index), "tags") : null
}

data "huaweicloud_vpc_subnets" "this" {
  count = length(var.query_subnet_names) > 0 ? 1 : 0
}

######################################################################
# Default security group
######################################################################

resource "huaweicloud_networking_secgroup" "this" {
  count = var.is_security_group_create ? 1 : 0

  name                 = var.security_group_name != "" ? var.security_group_name : null
  description          = var.security_group_description != "" ? var.security_group_description : null
  delete_default_rules = true

  enterprise_project_id = var.enterprise_project_id != "" ? var.enterprise_project_id : null
}

data "huaweicloud_networking_secgroups" "this" {
  count = length(var.query_security_group_names) > 0 ? 1 : 0
}

data "huaweicloud_networking_secgroup_rules" "this" {
  depends_on = [
    huaweicloud_networking_secgroup_rule.in_v4_self_group,
    huaweicloud_networking_secgroup_rule.this,
    huaweicloud_networking_secgroup_rule.remote_address_group,
  ]

  count = var.is_security_group_create ? 1 : 0

  security_group_id = huaweicloud_networking_secgroup.this[0].id
}

######################################################################
# Default security group rule
######################################################################

# Allow ECSs in the security group to which this rule belongs to communicate with each other
resource "huaweicloud_networking_secgroup_rule" "in_v4_self_group" {
  count = var.is_security_group_create ? 1 : 0

  security_group_id = huaweicloud_networking_secgroup.this[0].id
  ethertype         = "IPv4"
  direction         = "ingress"
  remote_group_id   = huaweicloud_networking_secgroup.this[0].id
}

######################################################################
# Custom Security Group Rules
######################################################################

locals {
  security_group_rules_without_remote_addresses = [for o in var.security_group_rules_configuration: o if try(length(lookup(o, "remote_addresses")), 0) < 1]
  security_group_rules_with_remote_addresses    = [for o in var.security_group_rules_configuration: o if try(length(lookup(o, "remote_addresses")), 0) > 0]
}

resource "huaweicloud_networking_secgroup_rule" "this" {
  count = var.is_security_group_create ? length(local.security_group_rules_without_remote_addresses) : 0

  security_group_id = huaweicloud_networking_secgroup.this[0].id

  description             = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "description") != "" ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "description") : null
  direction               = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "direction") != "" ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "direction") : null
  ethertype               = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "ethertype") != "" ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "ethertype") : null
  protocol                = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "protocol") != "" ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "protocol") : null
  ports                   = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "ports") != "" ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "ports") : null
  remote_ip_prefix        = (lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_group_id") == "" || lookup(element(local.security_group_rules_without_remote_addresses, count.index),
    "remote_group_id") == null) && (lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_address_group_id") == "" || lookup(element(local.security_group_rules_without_remote_addresses, count.index),
    "remote_address_group_id") == null) ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_ip_prefix") : null
  remote_group_id         = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_group_id")
  remote_address_group_id = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_group_id") == "" || lookup(element(local.security_group_rules_without_remote_addresses, count.index),
    "remote_group_id") == null ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_address_group_id") : null
  action                  = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "action") != "" ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "action") : null
  priority                = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "priority") != 0 ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "priority") : null
}

resource "huaweicloud_vpc_address_group" "security_group_rules_auto_created" {
  count = var.is_security_group_create ? length(local.security_group_rules_with_remote_addresses) : 0

  name       = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "address_group_name")
  ip_version = try(regexall("\\d+", lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ethertype"))[0], null)
  addresses  = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "remote_addresses")

  lifecycle {
    precondition {
      condition     = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "address_group_name") != "" && lookup(element(local.security_group_rules_with_remote_addresses, count.index), "address_group_name") != null
      error_message = "Field address_group_name is required if field remote_addresses are specified"
    }
    precondition {
      condition     = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "remote_addresses") != "" && lookup(element(local.security_group_rules_with_remote_addresses, count.index), "remote_addresses") != null
      error_message = "Invalid input for field 'ethertype', should be 'IPv4' or 'IPv6'"
    }
    precondition {
      condition     = can(regex("\\d+", lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ethertype")))
      error_message = "Invalid input for field 'ethertype', should be 'IPv4' or 'IPv6'"
    }
  }
}

resource "huaweicloud_networking_secgroup_rule" "remote_address_group" {
  count = var.is_security_group_create ? length(local.security_group_rules_with_remote_addresses) : 0

  security_group_id = huaweicloud_networking_secgroup.this[0].id

  description             = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "description") != "" ? lookup(element(local.security_group_rules_with_remote_addresses, count.index), "description") : null
  direction               = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "direction") != "" ? lookup(element(local.security_group_rules_with_remote_addresses, count.index), "direction") : null
  ethertype               = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ethertype") != "" ? lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ethertype") : null
  protocol                = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "protocol") != "" ? lookup(element(local.security_group_rules_with_remote_addresses, count.index), "protocol") : null
  ports                   = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ports") != "" ? lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ports") : null
  remote_address_group_id = huaweicloud_vpc_address_group.security_group_rules_auto_created[count.index].id
  action                  = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "action") != "" ? lookup(element(local.security_group_rules_with_remote_addresses, count.index), "action") : null
  priority                = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "priority") != 0 ? lookup(element(local.security_group_rules_with_remote_addresses, count.index), "priority") : null
}

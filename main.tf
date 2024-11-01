######################################################################
# Default VPC
######################################################################

resource "huaweicloud_vpc" "this" {
  count = var.is_vpc_create ? 1 : 0

  name            = var.name_suffix != "" ? format("%s%s", var.vpc_name, var.name_suffix) : var.vpc_name
  cidr            = var.vpc_cidr
  description     = var.vpc_description
  secondary_cidrs = var.vpc_secondary_cidrs
  tags            = var.vpc_tags

  enterprise_project_id = var.enterprise_project_id

  lifecycle {
    precondition {
      condition     = var.is_vpc_create && var.vpc_name != ""
      error_message = "Argument 'vpc_name' is required if the value of argument 'is_vpc_create' is true"
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

  name        = var.name_suffix != "" ? format("%s%s", lookup(element(var.subnets_configuration, count.index), "name"), var.name_suffix) : lookup(element(var.subnets_configuration, count.index), "name")
  description = lookup(element(var.subnets_configuration, count.index), "description")
  cidr        = lookup(element(var.subnets_configuration, count.index), "cidr")
  gateway_ip  = cidrhost(lookup(element(var.subnets_configuration, count.index), "cidr"), 1)
  ipv6_enable = lookup(element(var.subnets_configuration, count.index), "ipv6_enabled")
  dhcp_enable = lookup(element(var.subnets_configuration, count.index), "dhcp_enabled")
  dns_list    = lookup(element(var.subnets_configuration, count.index), "dns_list")

  tags = lookup(element(var.subnets_configuration, count.index), "tags")
}

data "huaweicloud_vpc_subnets" "this" {
  count = length(var.query_subnet_names) > 0 ? 1 : 0
}

######################################################################
# Default security group
######################################################################

resource "huaweicloud_networking_secgroup" "this" {
  count = var.is_security_group_create ? 1 : 0

  name                 = var.name_suffix != "" ? format("%s%s", var.security_group_name, var.name_suffix) : var.security_group_name
  description          = var.security_group_description
  delete_default_rules = true

  enterprise_project_id = var.enterprise_project_id
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

  security_group_id = try(huaweicloud_networking_secgroup.this[0].id, null)
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
  security_group_rules_without_remote_addresses = [for o in var.security_group_rules_configuration: o if length(lookup(o, "remote_addresses")) < 1]
  security_group_rules_with_remote_addresses    = [for o in var.security_group_rules_configuration: o if length(lookup(o, "remote_addresses")) > 0]
}

resource "huaweicloud_networking_secgroup_rule" "this" {
  count = var.is_security_group_create ? length(local.security_group_rules_without_remote_addresses) : 0

  security_group_id = huaweicloud_networking_secgroup.this[0].id

  description             = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "description")
  direction               = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "direction")
  ethertype               = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "ethertype")
  protocol                = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "protocol")
  ports                   = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "ports")
  remote_ip_prefix        = lookup(element(local.security_group_rules_without_remote_addresses, count.index),
    "remote_group_id") == null && lookup(element(local.security_group_rules_without_remote_addresses, count.index),
    "remote_address_group_id") == null ? lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_ip_prefix") : null
  remote_group_id         = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_group_id")
  remote_address_group_id = lookup(element(local.security_group_rules_without_remote_addresses, count.index),
    "remote_group_id") != null ? null : lookup(element(local.security_group_rules_without_remote_addresses, count.index), "remote_address_group_id")
  action                  = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "action")
  priority                = lookup(element(local.security_group_rules_without_remote_addresses, count.index), "priority")
}

resource "huaweicloud_vpc_address_group" "security_group_rules_auto_created" {
  count = var.is_security_group_create ? length(local.security_group_rules_with_remote_addresses) : 0

  name       = var.name_suffix != "" ? format("%s%s", lookup(element(local.security_group_rules_with_remote_addresses, count.index), "address_group_name"),
    var.name_suffix) : lookup(element(local.security_group_rules_with_remote_addresses, count.index), "address_group_name")
  ip_version = try(regexall("\\d+", lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ethertype"))[0], null)
  addresses  = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "remote_addresses")
}

resource "huaweicloud_networking_secgroup_rule" "remote_address_group" {
  count = var.is_security_group_create ? length(local.security_group_rules_with_remote_addresses) : 0

  security_group_id = huaweicloud_networking_secgroup.this[0].id

  description             = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "description")
  direction               = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "direction")
  ethertype               = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ethertype")
  protocol                = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "protocol")
  ports                   = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "ports")
  remote_address_group_id = huaweicloud_vpc_address_group.security_group_rules_auto_created[count.index].id
  action                  = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "action")
  priority                = lookup(element(local.security_group_rules_with_remote_addresses, count.index), "priority")
}

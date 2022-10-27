######################################################################
# Default VPC
######################################################################

resource "huaweicloud_vpc" "this" {
  count = var.is_vpc_create ? 1 : 0

  name = var.name_suffix != "" ? format("%s-%s", var.vpc_name, var.name_suffix) : var.vpc_name
  cidr = var.vpc_cidr_block

  enterprise_project_id = var.enterprise_project_id
}

######################################################################
# All subnets under VPC resource
######################################################################

resource "huaweicloud_vpc_subnet" "this" {
  count = var.is_vpc_create && length(var.subnets_configuration) > 0 ? length(var.subnets_configuration) : 0

  vpc_id = huaweicloud_vpc.this[0].id

  name        = var.name_suffix != "" ? format("%s-%s", lookup(element(var.subnets_configuration, count.index), "name"), var.name_suffix) : lookup(element(var.subnets_configuration, count.index), "name")
  description = lookup(element(var.subnets_configuration, count.index), "description")
  cidr        = lookup(element(var.subnets_configuration, count.index), "cidr")
  gateway_ip  = cidrhost(lookup(element(var.subnets_configuration, count.index), "cidr"), 1)
  ipv6_enable = lookup(element(var.subnets_configuration, count.index), "ipv6_enabled")
  dhcp_enable = lookup(element(var.subnets_configuration, count.index), "dhcp_enabled")
  dns_list    = lookup(element(var.subnets_configuration, count.index), "dns_list")

  tags = merge(
    { "Name" = var.name_suffix != "" ? format("%s-%s", lookup(element(var.subnets_configuration, count.index), "name"), var.name_suffix) : lookup(element(var.subnets_configuration, count.index), "name")},
    lookup(element(var.subnets_configuration, count.index), "tags")
  )
}

######################################################################
# Default security group
######################################################################

resource "huaweicloud_networking_secgroup" "this" {
  count = var.is_security_group_create ? 1 : 0

  name                 = var.name_suffix != "" ? format("%s-secgroup", var.name_suffix) : var.security_group_name
  description          = var.security_group_description
  delete_default_rules = true

  enterprise_project_id = var.enterprise_project_id
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

resource "huaweicloud_networking_secgroup_rule" "this" {
  count = var.is_security_group_create && length(var.security_group_rules_configuration) > 0 ? length(var.security_group_rules_configuration) : 0

  security_group_id = huaweicloud_networking_secgroup.this[0].id

  description      = lookup(element(var.security_group_rules_configuration, count.index), "description")
  direction        = lookup(element(var.security_group_rules_configuration, count.index), "direction")
  ethertype        = lookup(element(var.security_group_rules_configuration, count.index), "ethertype")
  protocol         = lookup(element(var.security_group_rules_configuration, count.index), "protocol")
  ports            = lookup(element(var.security_group_rules_configuration, count.index), "ports")
  remote_ip_prefix = lookup(element(var.security_group_rules_configuration, count.index), "remote_ip_prefix")
  action           = lookup(element(var.security_group_rules_configuration, count.index), "action")
  priority         = lookup(element(var.security_group_rules_configuration, count.index), "priority")
}

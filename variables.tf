######################################################################
# Public configurations
######################################################################

variable "enterprise_project_id" {
  description = "Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users)"

  type    = string
  default = ""
}

variable "availability_zone" {
  description = "The availability zone to which the VPC subnet resource belongs"

  type    = string
  default = ""
}

######################################################################
# Configuration of VPC resource and related resources
######################################################################

variable "is_vpc_create" {
  description = "Controls whether a VPC should be created (it affects all VPC related resources under this module)"

  type     = bool
  default  = true
  nullable = false
}

variable "vpc_name" {
  description = "The name of the VPC resource"

  type    = string
  default = ""
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC resource"

  type    = string
  default = ""
}

variable "vpc_description" {
  description = "The description of the VPC resource"

  type    = string
  default = ""
}

variable "vpc_secondary_cidrs" {
  description = "The secondary CIDR blocks of the VPC resource"

  type     = list(string)
  default  = []
  nullable = false
}

variable "vpc_tags" {
  description = "The key/value pairs to associte with the VPC resource"

  type     = map(string)
  default  = {}
  nullable = false
}

variable "subnets_configuration" {
  description = "The configuration for the subnet resources to which the VPC belongs"

  type = list(object({
    name         = string
    cidr         = string
    gateway_ip   = optional(string, "")
    description  = optional(string, "")
    ipv6_enabled = optional(bool, null)
    dhcp_enabled = optional(bool, null)
    dns_list     = optional(list(string), [])
    tags         = optional(map(string), {})
  }))
  default  = []
  nullable = false
}

######################################################################
# Configuration of security group resource and related resources
######################################################################

variable "is_security_group_create" {
  description = "Controls whether a security group should be created (it affects all security group related resources under this module)"

  type     = bool
  default  = true
  nullable = false
}

variable "security_group_name" {
  description = "The name of the security group resource"

  type    = string
  default = ""
}

variable "security_group_description" {
  description = "The description of the security group resource"

  type    = string
  default = ""
}

variable "security_group_rules_configuration" {
  description = "The configuration for security group rule resources to which the security group belongs"

  type = list(object({
    description             = optional(string, "")
    direction               = optional(string, "ingress")
    ethertype               = optional(string, "IPv4")
    protocol                = optional(string, "")
    ports                   = optional(string, "")
    remote_ip_prefix        = optional(string, "0.0.0.0/0")
    remote_group_id         = optional(string, "")
    remote_address_group_id = optional(string, "")
    address_group_name      = optional(string, "")
    remote_addresses        = optional(list(string), [])
    action                  = optional(string, "allow")
    priority                = optional(number, 0)
  }))
  default  = []
  nullable = false
}

#################################################################
# Resource name list configuration for data source queries
######################################################################

variable "query_vpc_names" {
  description = "The VPC name list used to query the resource IDs"

  type     = list(string)
  default  = []
  nullable = false
}

variable "query_subnet_names" {
  description = "The subnet name list used to query the resource IDs"

  type     = list(string)
  default  = []
  nullable = false
}

variable "query_security_group_names" {
  description = "The security group name list used to query the resource IDs"

  type     = list(string)
  default  = []
  nullable = false
}

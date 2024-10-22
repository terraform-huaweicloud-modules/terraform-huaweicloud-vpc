######################################################################
# Configuration of Enterprise Project
######################################################################

variable "enterprise_project_id" {
  description = "Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users)"

  type     = string
  default  = null
  nullable = true
}

######################################################################
# Public configurations
######################################################################

# Specifies the suffix name for network resources, if omitted, using vpc_name, subnet_name, security_group_name to
# create network resources.
variable "name_suffix" {
  description = "The suffix string of name for all Network resources"

  type    = string
  default = ""
}

######################################################################
# Configuration of VPC resource and related resources
######################################################################

variable "is_vpc_create" {
  description = "Controls whether a VPC should be created (it affects all VPC related resources under this module)"

  type    = bool
  default = true
}

variable "vpc_name" {
  description = "The name of the VPC resource"

  type    = string
  default = ""
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC resource"

  type    = string
  default = "192.168.0.0/16"
}

variable "vpc_description" {
  description = "The description of the VPC resource"

  type    = string
  default = ""
}

variable "vpc_secondary_cidrs" {
  description = "The secondary CIDR blocks of the VPC resource"

  type    = list(string)
  default = []
}

variable "vpc_tags" {
  description = "The key/value pairs to associte with the VPC resource"

  type    = map(string)
  default = {}
}

variable "subnets_configuration" {
  description = "The configuration for the subnet resources to which the VPC belongs"

  type = list(object({
    name         = string
    description  = optional(string, null)
    cidr         = string
    ipv6_enabled = optional(bool, true)
    dhcp_enabled = optional(bool, true)
    dns_list     = optional(list(string), null)
    tags         = optional(map(string), {})
    delete_timeout = optional(string, null)
  }))

  default = [
    {
      name = "module-default-subnet"
      cidr = "192.168.16.0/20"
    }
  ]
}

######################################################################
# Configuration of security group resource and related resources
######################################################################

variable "is_security_group_create" {
  description = "Controls whether a security group should be created (it affects all security group related resources under this module)"

  type    = bool
  default = true
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
    description             = optional(string, null)
    direction               = optional(string, "ingress")
    ethertype               = optional(string, "IPv4")
    protocol                = optional(string, null)
    ports                   = optional(string, null)
    remote_ip_prefix        = optional(string, "0.0.0.0/0")
    remote_group_id         = optional(string, null)
    remote_address_group_id = optional(string, null)
    action                  = optional(string, "allow")
    priority                = optional(number, null)
  }))

  default = []
}

variable "remote_address_group_rules_configuration" {
  description = "The configuration of remote address group for security group rule resources"

  type = list(object({
    address_group_name = string
    description        = optional(string, null)
    direction          = optional(string, "ingress")
    ethertype          = optional(string, "IPv4")
    protocol           = optional(string, null)
    ports              = optional(string, null)
    remote_addresses   = list(string)
    action             = optional(string, "allow")
    priority           = optional(number, null)
  }))

  default = []
}

######################################################################
# Resource name list configuration for data source queries
######################################################################

variable "query_vpc_names" {
  description = "The VPC name list used to query the resource IDs"

  type    = list(string)
  default = []
}

variable "query_subnet_names" {
  description = "The subnet name list used to query the resource IDs"

  type    = list(string)
  default = []
}

variable "query_security_group_names" {
  description = "The security group name list used to query the resource IDs"

  type    = list(string)
  default = []
}

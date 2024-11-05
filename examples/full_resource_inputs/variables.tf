######################################################################
# Public configurations
######################################################################

variable "enterprise_project_id" {
  description = "Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users)"

  type = string
}

######################################################################
# Configuration of VPC resource and related resources
######################################################################

variable "vpc_name" {
  description = "The name of the VPC resource"

  type = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC resource"

  type = string
}

variable "vpc_description" {
  description = "The description of the VPC resource"

  type = string
}

variable "vpc_secondary_cidrs" {
  description = "The secondary CIDR block of the VPC resource"

  type = list(string)
}

variable "vpc_tags" {
  description = "The key/value pairs to associte with the VPC resource"

  type = map(string)
}

variable "subnets_configuration" {
  description = "The configuration for the subnet resources to which the VPC belongs"

  type = list(object({
    name         = string
    description  = optional(string, "")
    cidr         = string
    ipv6_enabled = optional(bool, true)
    dhcp_enabled = optional(bool, true)
    dns_list     = optional(list(string), [])
    tags         = optional(map(string), {})
  }))
}

######################################################################
# Configuration of security group resource and related resources
######################################################################

variable "security_group_name" {
  description = "The name of the security group resource"

  type = string
}

variable "security_group_description" {
  description = "The description of the security group resource"

  type = string
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
}

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
# Configuration of security group resource and related resources
######################################################################

variable "security_group_name" {
  description = "The name of the security group resource"

  type = string
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
}

variable "remote_address_group_rules_configuration" {
  description = "The configuration of remote address group for security group rule resources"

  type = list(object({
    description      = optional(string, null)
    direction        = optional(string, "ingress")
    ethertype        = optional(string, "IPv4")
    protocol         = optional(string, null)
    ports            = optional(string, null)
    remote_addresses = list(string)
    action           = optional(string, "allow")
    priority         = optional(number, null)
  }))
}

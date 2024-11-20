######################################################################
# Public configurations
######################################################################

variable "enterprise_project_id" {
  description = "Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users)"

  type = string
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
    action                  = optional(string, "allow")
    priority                = optional(number, 0)
  }))
}

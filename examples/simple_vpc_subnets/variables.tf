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
    description  = optional(string, null)
    cidr         = string
    ipv6_enabled = optional(bool, true)
    dhcp_enabled = optional(bool, true)
    dns_list     = optional(list(string), null)
    tags         = optional(map(string), {})
    delete_timeout = optional(string, null)
  }))
}

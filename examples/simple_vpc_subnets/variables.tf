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
  default = "192.168.0.0/16"
}

variable "vpc_secondary_cidrs" {
  description = "The secondary CIDR block of the VPC resource"

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

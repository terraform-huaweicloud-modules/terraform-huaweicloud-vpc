######################################################################
# Configuration of VPC resource and related resources
######################################################################

variable "vpc_name" {
  description = "The name of the VPC resource"

  type    = string
  default = ""
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC resource"

  type    = string
  default = "192.168.0.0/16"
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

# Whether to create a security group
variable "is_security_group_create" {
  description = "Controls whether a security group should be created (it affects all security group related resources under this module)"

  type    = bool
  default = true
}

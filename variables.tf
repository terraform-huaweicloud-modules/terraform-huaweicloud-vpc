variable "vpc_id" {
  description = "The ID of the VPC"
  default     = ""
}

variable "name" {
  description = "The name of the VPC"
  default     = ""
}

variable "cidr" {
  description = "The CIDR of the VPC"
  default     = ""
}

variable "subnets" {
  description = "List of subnets in the VPC"
  type = list(object({
    name          = string
    cidr          = string
    gateway_ip    = string
    primary_dns   = string
    secondary_dns = string
  }))
  default = []
}

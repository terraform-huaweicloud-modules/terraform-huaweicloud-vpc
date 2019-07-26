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
  type = list(map(string))
  description = "List of subnets in the VPC"
  default     = []
}

output "this_vpc_id" {
  description = "The ID of the VPC"
  value       = "${var.vpc_id=="" ? join("",huaweicloud_vpc_v1.this.*.id) : var.vpc_id}"
}

output "this_subnet_ids" {
  description = "List of IDs of the Subnets"
  value       = "${join(",",huaweicloud_vpc_subnet_v1.this.*.subnet_id)}"
}

output "this_network_ids" {
  description = "List of Network IDs of the Subnets"
  value       = "${join(",",huaweicloud_vpc_subnet_v1.this.*.id)}"
}

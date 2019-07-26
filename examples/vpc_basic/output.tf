output "this_vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.example.this_vpc_id}"
}

output "this_subnet_ids" {
  description = "List of IDs of the Subnets"
  value       = "${module.example.this_subnet_ids}"
}

output "this_network_ids" {
  description = "List of Network IDs of the Subnets"
  value       = "${module.example.this_network_ids}"
}

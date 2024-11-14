output "vpc_id" {
    description = "The ID of the VPC resource"
    value       = try(huaweicloud_vpc.this[0].id, "")
}

output "vpc_cidr" {
    description = "The CIDR block of the VPC resource"
    value       = try(huaweicloud_vpc.this[0].id, "")
}

output "subnet_cidrs" {
    description = "The CIDR list of the subnet resources to which the VPC resource belongs"
    value       = try(huaweicloud_vpc_subnet.this[*].cidr, [])
}

output "subnet_ids" {
    description = "The ID list of the subnet resources to which the VPC resource belongs"
    value       = try(huaweicloud_vpc_subnet.this[*].id, [])
}

output "security_group_id" {
    description = "The ID of the security group resource"
    value       = try(huaweicloud_networking_secgroup.this[0].id, "")
}

output "security_group_rules" {
    description = "All rules to which the security group resource belongs"
    value       = try(data.huaweicloud_networking_secgroup_rules.this[*].rules, [])
}

output "queried_vpc_ids" {
    description = "The ID list of the VPC resources for data-source query by resource name"
    value       = [for v in flatten(data.huaweicloud_vpcs.this[*].vpcs): v.id if contains(var.query_vpc_names, v.name)]
}

output "queried_subnet_ids" {
    description = "The ID list of the subnet resources for data-source query by resource name"
    value       = [for v in flatten(data.huaweicloud_vpc_subnets.this[*].subnets): v.id if contains(var.query_subnet_names, v.name)]
}

output "queried_security_group_ids" {
    description = "The ID list of the security group resources for data-source query by resource name"
    value       = [for v in flatten(data.huaweicloud_networking_secgroups.this[*].security_groups): v.id if contains(var.query_security_group_names, v.name)]
}

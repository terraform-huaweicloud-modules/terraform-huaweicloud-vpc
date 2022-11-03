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
    value       = try(huaweicloud_vpc.this[*].cidr, [])
}

output "subnet_ids" {
    description = "The ID list of the subnet resources to which the VPC resource belongs"
    value       = try(huaweicloud_vpc.this[*].id, [])
}

output "security_group_id" {
    description = "The ID of the security group resource"
    value       = try(huaweicloud_networking_secgroup.this[0].id, "")
}

output "security_group_rules" {
    description = "All rules to which the security group resource belongs"
    value       = try(huaweicloud_networking_secgroup.this[0].rules, null)
}

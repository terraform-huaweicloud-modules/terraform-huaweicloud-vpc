output "vpc_id" {
    description = "The ID of the VPC resource"
    value       = module.vpc_service.vpc_id
}

output "vpc_cidr" {
    description = "The CIDR block of the VPC resource"
    value       = module.vpc_service.vpc_cidr
}

output "subnet_cidrs" {
    description = "The CIDR list of the subnet resources to which the VPC resource belongs"
    value       = module.vpc_service.subnet_cidrs
}

output "subnet_ids" {
    description = "The ID list of the subnet resources to which the VPC resource belongs"
    value       = module.vpc_service.subnet_ids
}

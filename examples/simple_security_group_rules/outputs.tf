output "security_group_id" {
  description = "The ID of the security group resource"

  value = module.vpc_service.security_group_id
}

output "security_group_rules" {
  description = "All rules to which the security group resource belongs"

  value = module.vpc_service.security_group_rules
}

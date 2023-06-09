output "security_group_id" {
  description = "The ID of the security group resource"
  value       = module.vpc_service.security_group_id
}

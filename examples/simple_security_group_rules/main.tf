module "vpc_service" {
  source = "../.."

  enterprise_project_id = var.enterprise_project_id
  name_suffix           = var.name_suffix

  is_vpc_create = false

  security_group_name                      = var.security_group_name
  security_group_description               = var.security_group_description
  security_group_rules_configuration       = var.security_group_rules_configuration
  remote_address_group_rules_configuration = var.remote_address_group_rules_configuration
}

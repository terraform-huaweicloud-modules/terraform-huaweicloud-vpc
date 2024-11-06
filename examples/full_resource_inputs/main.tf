module "vpc_service" {
  source = "../.."

  enterprise_project_id = var.enterprise_project_id

  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  vpc_description       = var.vpc_description
  vpc_secondary_cidrs   = var.vpc_secondary_cidrs
  vpc_tags              = var.vpc_tags
  subnets_configuration = var.subnets_configuration

  security_group_name                = var.security_group_name
  security_group_description         = var.security_group_description
  security_group_rules_configuration = var.security_group_rules_configuration
}

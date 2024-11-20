module "vpc_service" {
  source = "../.."

  enterprise_project_id = var.enterprise_project_id

  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  vpc_description       = var.vpc_description
  vpc_secondary_cidrs   = var.vpc_secondary_cidrs
  vpc_tags              = var.vpc_tags
  subnets_configuration = var.subnets_configuration

  is_security_group_create = false
}

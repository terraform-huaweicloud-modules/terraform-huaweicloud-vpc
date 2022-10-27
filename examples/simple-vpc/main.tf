module "vpc_service" {
  source = "../.."

  vpc_name       = "module-single-vpc"
  vpc_cidr_block = "172.16.0.0/16"

  subnets_configuration = [
    {name="module-single-master-subnet", cidr="172.16.66.0/24"},
    {name="module-single-standby-subnet", cidr="172.16.86.0/24"},
  ]

  is_security_group_create = false
}

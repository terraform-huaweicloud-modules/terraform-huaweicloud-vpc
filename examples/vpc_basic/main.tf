provider "huaweicloud" {
  access_key  = "AK"
  secret_key  = "SK"
  auth_url    = "https://iam.cn-north-1.myhwclouds.com:443/v3"
  region      = "cn-north-1"
  tenant_name = "cn-north-1"
}

module "example" {
  source ="../.."

  // VPC
  name        = "testVPC"
  description = "testVPC description"

  // VPC Subnet
  subnets = [
    {
      name       = "testSubnet-1"
      cidr       = "10.0.1.0/24"
      gateway_ip = "10.0.1.1"
    },
    {
      name       = "testSubnet-2"
      cidr       = "10.0.2.0/24"
      gateway_ip = "10.0.2.1"
      availability_zone = "cn-north-1"
    },
    {
      name       = "tetSubnet-3"
      cidr       = "10.0.3.0/24"
      gateway_ip = "10.0.3.1"
      primary_dns = "100.125.1.250"
      secondary_dns = "100.125.3.250"
    },
  ]
}

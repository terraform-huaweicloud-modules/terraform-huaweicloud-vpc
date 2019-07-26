# Huawei Cloud VPC Terraform Module

Terraform moudle which create VPC resource on Huawei Cloud.

These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/huaweicloud/r/vpc_v1.html)
* [VPC Subnet](https://www.terraform.io/docs/providers/huaweicloud/r/vpc_subnet_v1.html)

## Usage

```hcl
module "example" {
  source = "terraform-huaweicloud-modules/vpc/huaweicloud"

  // VPC
  name = "testVPC"
  cidr = "10.0.0.0/16"

  // Subnet
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
      availability_zone = "ap-southeast-1a"
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
```

## Conditional creation

This module can create both VPC and VPC subnet, it is possible to use existing VPC only if you
specify `vpc_id` parameter.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_id  | Specifying existing VPC ID  | string  | `""`  | no  |
| name  | The name of the VPC  | string  | `""`  | no  |
| cidr  | The CIDR of the VPC  | string  | `""`  | no  |
| subnets  | List of subnets in the VPC  | `list(map(string))`  | `[]`  | no  |


## Outputs

| Name | Description |
|------|-------------|
| this_vpc_id | The ID of the VPC |
| this_subnet_ids | The IDs of the Subnets |
| this_network_ids | The Network IDs of the Subnets |

Authors
----
Created and maintained by [Zhenguo Niu](https://github.com/niuzhenguo)

License
----
Apache 2 Licensed. See LICENSE for full details.

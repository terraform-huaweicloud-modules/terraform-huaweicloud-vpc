# The Terraform module of HUAWEI Cloud VPC service

The terraform module for one-click deployment of VPC and related resources.

## Usage

```hcl
module "vpc_service" {
  source = "terraform-huaweicloud-modules/vpc-service"

  vpc_name       = "module-single-vpc"
  vpc_cidr_block = "172.16.0.0/16"

  subnet_configuration = [
    {name="module-single-master-subnet", cidr="172.16.66.0/24"},
    {name="module-single-standby-subnet", cidr="172.16.86.0/24"},
  ]

  is_security_group_create = false
}
```

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/issues/new)
section.

Full contributing [guidelines are covered here](.github/how_to_contribute.md).

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3.0 |
| Huaweicloud Provider | >= 1.40.0 |

## Resources

| Name | Type |
|------|------|
| huaweicloud_vpc.this | resource |
| huaweicloud_vpc_subnet.this | resource |
| huaweicloud_networking_secgroup.this | resource |
| huaweicloud_networking_secgroup_rule.in_v4_self_group | resource |
| huaweicloud_networking_secgroup_rule.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | string | null | N |
| name_suffix | The suffix string of name for all Network resources | string | "" | N |
| is_vpc_create | Controls whether a VPC should be created (it affects all VPC related resources under this module) | bool | true | N |
| vpc_name | The name of the VPC resource | string | "" | N |
| vpc_cidr_block | The CIDR block of the VPC resource | string | "192.168.0.0/16" | N |
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | list(object) | <pre>[<br>  {<br>    name = "module-default-subnet",<br>    cidr = "192.168.16.0/20",<br>  },<br>]</pre> | N |
| is_security_group_create | Controls whether a security group should be created (it affects all security group related resources under this module) | bool | true | N |
| security_group_name | The name of the security group resource" | string | "" | N |
| security_group_description | The description of the security group resource | string | null | N |
| security_group_rules_configuration | The configuration for security group rule resources to which the security group belongs | list(object) | <pre>[<br>  {<br>    protocol = "icmp"<br>  }<br>]</pre> | N |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC resource |
| vpc_cidr | The CIDR block of the VPC resource |
| subnet_cidrs | The CIDR list of the subnet resources to which the VPC resource belongs |
| subnet_ids | The ID list of the subnet resources to which the VPC resource belongs |
| security_group_id | The ID of the security group resource |
| security_group_rules | All rules to which the security group resource belongs |

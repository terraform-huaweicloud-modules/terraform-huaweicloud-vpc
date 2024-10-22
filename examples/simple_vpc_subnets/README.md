# Simple VPC

Configuration in this directory creates a default VPC resource and two associated subnets.

Referring to this use case you can write a basic VPC resource configuration.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources but not spend money (VPCs and associated subnets are free, but they have
quota limits). Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.3.0 |
| Huaweicloud Provider | >= 1.40.0 |

## Providers

[terraform-provider-huaweicloud](https://github.com/huaweicloud/terraform-provider-huaweicloud)

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | [../../](../../README.md) | N/A |

## Resources

| Name | Type |
|------|------|
| huaweicloud_vpc.this[0] | resource |
| huaweicloud_vpc_subnet.this[0] | resource |
| huaweicloud_vpc_subnet.this[1] | resource |

## Inputs

<!-- markdownlint-disable MD013 -->
| Name | Description | Type | Value |
|------|-------------|------|-------|
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | string | "0" |
| name_suffix | The suffix string of name for all Network resources | string | "tf_test_" |
| is_security_group_create | Controls whether a VPC should be created (it affects all VPC related resources under this module) | bool | true |
| vpc_name | The name of the VPC resource | string | demo |
| vpc_cidr | The CIDR block of the VPC resource | string | "172.16.128.0/20" |
| vpc_description | The description of the VPC resource | string | "Created by terraform module" |
| vpc_secondary_cidrs | The secondary CIDR blocks of the VPC resource | list(string) | <pre>["172.16.192.0/20"]</pre> |
| vpc_tags | The key/value pairs to associte with the VPC resource | map(string) | <pre>{<br>  "foo": "bar"<br>}</pre> |
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | <pre>list(object({<br>  name           = string<br>  description    = optional(string, null)<br>  cidr           = string<br>  ipv6_enabled   = optional(bool, true)<br>  dhcp_enabled   = optional(bool, true)<br>  dns_list       = optional(list(string), null)<br>  tags           = optional(map(string), {})<br>  delete_timeout = optional(string, null)<br>}))</pre> | <pre>[<br>  {name="demo-master", description="Created by terraform module", cidr="172.16.136.0/24", ipv6_enabled=false, dhcp_enabled=false, dns_list=["5.5.5.5"], tags={"foo": "bar"}, delete_timeout="30m"},<br>  {name="demo-slave", cidr="172.16.138.0/24"},<br>]</pre> |
| is_security_group_create | Controls whether a security group should be created (it affects all security group related resources under this module) | bool | false |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC resource |
| vpc_cidr | The CIDR block of the VPC resource |
| subnet_cidrs | The CIDR list of the subnet resources to which the VPC resource belongs |
| subnet_ids | The ID list of the subnet resources to which the VPC resource belongs |

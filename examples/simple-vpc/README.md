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

| Name | Description | Type | Value |
|------|-------------|------|-------|
| vpc_name | The name of the VPC resource | string | module-single-vpc |
| vpc_cidr_block | The CIDR block of the VPC resource | string | "172.16.0.0/16" |
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | list(object) | <pre>[<br>  {<br>    name = "module-single-master-subnet",<br>    cidr = "172.16.66.0/24",<br>  },<br>  {<br>    name = "module-single-standby-subnet",<br>    cidr = "172.16.86.0/24",<br>  },<br>]</pre> |
| vpc_name | Controls whether a security group should be created (it affects all security group related resources under this module) | bool | false |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC resource |
| vpc_cidr | The CIDR block of the VPC resource |
| subnet_cidrs | The CIDR list of the subnet resources to which the VPC resource belongs |
| subnet_ids | The ID list of the subnet resources to which the VPC resource belongs |

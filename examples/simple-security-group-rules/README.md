# Simple security group rules

Configuration in this directory creates a security resource and five rules (contains a default ingress remote rule).

Referring to this use case you can write a basic security group and related resources configuration.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources but not spend money (security group and rules are free, but they have
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
| huaweicloud_networking_secgroup.this[0] | resource |
| huaweicloud_networking_secgroup_rule.in_v4_self_group[0] | resource |
| huaweicloud_networking_secgroup_rule.this[1] | resource |

## Inputs

| Name | Description | Type | Value |
|------|-------------|------|-------|
| security_group_name | The name of the security group resource | string | module-single-security-group |

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | The ID of the security group resource |

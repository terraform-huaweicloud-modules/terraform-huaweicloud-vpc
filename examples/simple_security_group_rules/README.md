# Simple security group rules

Configuration in this directory creates these resources as follows:

+ A security group
+ Five security group rules (contains a default ingress remote rule).

And doing a resources query for security group rules by a data source.

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
| huaweicloud_networking_secgroup_rule.this[0] | resource |
| huaweicloud_networking_secgroup_rule.this[1] | resource |
| huaweicloud_networking_secgroup_rule.this[2] | resource |
| huaweicloud_networking_secgroup_rule.this[3] | resource |
| data.huaweicloud_networking_secgroup_rules.this | data-source |

## Inputs

<!-- markdownlint-disable MD013 -->
| Name | Description | Type | Value |
|------|-------------|------|-------|
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | string | "0" |
| is_vpc_create | Controls whether a VPC should be created (it affects all VPC related resources under this module) | bool | false |
| security_group_name | The name of the security group resource | string | "demo" |
| security_group_description | The description of the security group resource | string | "Created by terraform module" |
| security_group_rules_configuration | The configuration for security group rule resources to which the security group belongs | <pre>list(object({<br>  description             = optional(string, null)<br>  direction               = optional(string, "ingress")<br>  ethertype               = optional(string, "IPv4")<br>  protocol                = optional(string, null)<br>  ports                   = optional(string, null)<br>  remote_ip_prefix        = optional(string, "0.0.0.0/0")<br>  remote_group_id         = optional(string, null)<br>  remote_address_group_id = optional(string, null)<br>  action                  = optional(string, "allow")<br>  priority                = optional(number, null)<br>}))</pre> | <pre>[<br>  {description="Created by terraform module", direction="ingress", ethertype="IPv6", protocol="tcp", ports="22", remote_ip_prefix="::/0", action="deny", priority=100},<br>  {protocol="tcp", ports="30000", priority=100},<br>  {protocol="icmp"},<br>]</pre> |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | The ID of the security group resource |
| security_group_rules | All rules to which the security group resource belongs |

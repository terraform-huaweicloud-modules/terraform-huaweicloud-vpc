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
| huaweicloud_networking_secgroup_rule.this[0] | resource |
| huaweicloud_networking_secgroup_rule.this[1] | resource |
| huaweicloud_networking_secgroup_rule.this[2] | resource |
| huaweicloud_networking_secgroup_rule.this[3] | resource |
| huaweicloud_vpc_address_group.this[0] | resource |
| huaweicloud_networking_secgroup_rule.remote_address_group[0] | resource |

## Inputs

| Name | Description | Type | Value |
|------|-------------|------|-------|
| is_vpc_create | Controls whether a VPC should be created (it affects all VPC related resources under this module) | bool | false |
| security_group_name | The name of the security group resource | string | module-single-security-group |
| security_group_rules_configuration |vThe configuration for security group rule resources to which the security group belongs | <pre>list(object({<br>  description             = optional(string, null)<br>  direction               = optional(string, "ingress")<br>  ethertype               = optional(string, "IPv4")<br>  protocol                = optional(string, null)<br>  ports                   = optional(string, null)<br>  remote_ip_prefix        = optional(string, "0.0.0.0/0")<br>  remote_group_id         = optional(string, null)<br>  remote_address_group_id = optional(string, null)<br>  action                  = optional(string, "allow")<br>  priority                = optional(number, null)<br>}))</pre> | <pre>[<br>  {direction="ingress", ethertype="IPv4", protocol="icmp"},<br>  {direction="ingress", ethertype="IPv6", protocol="icmp", remote_ip_prefix="::/0"},<br>  {direction="egress", ethertype="IPv4"},<br>  {direction="egress", ethertype="IPv6", remote_ip_prefix="::/0"},<br>]</pre> |
| remote_address_group_rules_configuration | The configuration of remote address group for security group rule resources | <pre>list(object({<br>  description      = optional(string, null)<br>  direction        = optional(string, "ingress")<br>  ethertype        = optional(string, "IPv4")<br>  protocol         = optional(string, null)<br>  ports            = optional(string, null)<br>  remote_addresses = list(string)<br>  action           = optional(string, "allow")<br>  priority         = optional(number, null)<br>}))</pre> |<pre>[<br>  {direction="ingress", ethertype="IPv4", protocol="icmp", ports="80", remote_addresses=["192.168.10.22,192.168.11.0-192.168.11.240"]},<br>]<pre> |

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | The ID of the security group resource |

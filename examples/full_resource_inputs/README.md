# Full resource inputs check

This example shows how to configure all the input parameters of the VPC mudule and create corresponding resources.
Based on different parameter configurations, we can create various required network-related resources.

Configuration in this directory creates these resources as follows:

+ A VPC
+ Two subnets
+ A security group
+ Six security group rules (contains a default ingress remote rule).

And doing a resources query for security group rules by a data source.

Referring to this use case you can write a basic security group and related resources configuration.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources but not spend money (VPC, subnets, security group and rules are free,
but they have quota limits). Run `terraform destroy` when you don't need these resources.

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

| Name (To be created) | Type |
|------|------|
| huaweicloud_vpc.this[0] | resource |
| huaweicloud_vpc_subnet.this[0] | resource |
| huaweicloud_vpc_subnet.this[1] | resource |
| huaweicloud_networking_secgroup.this[0] | resource |
| huaweicloud_networking_secgroup_rule.in_v4_self_group[0] | resource |
| huaweicloud_networking_secgroup_rule.this[0] | resource |
| huaweicloud_networking_secgroup_rule.this[1] | resource |
| huaweicloud_networking_secgroup_rule.this[2] | resource |
| huaweicloud_networking_secgroup_rule.this[3] | resource |
| huaweicloud_vpc_address_group.this[0] | resource |
| huaweicloud_networking_secgroup_rule.remote_address_group[0] | resource |
| huaweicloud_networking_secgroup_rule.remote_address_group[1] | resource |
| data.huaweicloud_networking_secgroup_rules.this[0] | data-source |

## Inputs

<!-- markdownlint-disable MD013 -->
| Name | Description | Type | Value |
|------|-------------|------|-------|
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | string | null |
| is_vpc_create | Controls whether a VPC should be created (it affects all VPC related resources under this module) | bool | false |
| name_suffix | The suffix string of name for all Network resources | string | "tf_test_" |
| vpc_name | The name of the VPC resource | string | demo |
| vpc_cidr | The CIDR block of the VPC resource | string | "172.16.128.0/20" |
| vpc_description | The description of the VPC resource | string | "Created by terraform module" |
| vpc_secondary_cidrs | The secondary CIDR blocks of the VPC resource | list(string) | <pre>["172.16.192.0/20"]</pre> |
| vpc_tags | The key/value pairs to associte with the VPC resource | map(string) | <pre>{<br>  "foo": "bar"<br>}</pre> |
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | <pre>list(object({<br>  name           = string<br>  description    = optional(string, null)<br>  cidr           = string<br>  ipv6_enabled   = optional(bool, true)<br>  dhcp_enabled   = optional(bool, true)<br>  dns_list       = optional(list(string), null)<br>  tags           = optional(map(string), {})<br>  delete_timeout = optional(string, null)<br>}))</pre> | <pre>[<br>  {name="demo-master", description="Created by terraform module", cidr="172.16.136.0/24", ipv6_enabled=false, dhcp_enabled=false, dns_list=["5.5.5.5"], tags={"foo": "bar"}, delete_timeout="30m"},<br>  {name="demo-slave", cidr="172.16.138.0/24"},<br>]</pre> |
| is_security_group_create | Controls whether a security group should be created (it affects all security group related resources under this module) | bool | true |
| security_group_name | The name of the security group resource | string | "demo" |
| security_group_description | The description of the security group resource | string | "Created by terraform module" |
| security_group_rules_configuration |vThe configuration for security group rule resources to which the security group belongs | <pre>list(object({<br>  description             = optional(string, null)<br>  direction               = optional(string, "ingress")<br>  ethertype               = optional(string, "IPv4")<br>  protocol                = optional(string, null)<br>  ports                   = optional(string, null)<br>  remote_ip_prefix        = optional(string, "0.0.0.0/0")<br>  remote_group_id         = optional(string, null)<br>  remote_address_group_id = optional(string, null)<br>  action                  = optional(string, "allow")<br>  priority                = optional(number, null)<br>}))</pre> | <pre>[<br>  {description="Created by terraform module", direction="ingress", ethertype="IPv4", protocol="icmp", priority=100},<br>  {description="Created by terraform module", direction="ingress", ethertype="IPv6", protocol="icmp", remote_ip_prefix="::/0", priority=100},<br>  {direction="egress", ethertype="IPv4", priority=1},<br>  {direction="egress", ethertype="IPv6", remote_ip_prefix="::/0", priority=1},<br>]</pre> |
| remote_address_group_rules_configuration | The configuration of remote address group for security group rule resources | <pre>list(object({<br>  description      = optional(string, null)<br>  direction        = optional(string, "ingress")<br>  ethertype        = optional(string, "IPv4")<br>  protocol         = optional(string, null)<br>  ports            = optional(string, null)<br>  remote_addresses = list(string)<br>  action           = optional(string, "allow")<br>  priority         = optional(number, null)<br>}))</pre> | <pre>[<br>  {description="Created by terraform module", direction="ingress", ethertype="IPv6", protocol="tcp", ports="22", remote_addresses=["FC00:0:130F:0:0:9C0:876A:130B"], action="deny", priority=100},<br>  {direction="ingress", ethertype="IPv4", protocol="tcp", ports="80", remote_addresses=["192.168.10.22,192.168.11.0-192.168.11.240"], priority=100},<br>]<pre> |
<!-- markdownlint-enable MD013 -->

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC resource |
| vpc_cidr | The CIDR block of the VPC resource |
| subnet_cidrs | The CIDR list of the subnet resources to which the VPC resource belongs |
| subnet_ids | The ID list of the subnet resources to which the VPC resource belongs |
| security_group_id | The ID of the security group resource |
| security_group_rules | All rules to which the security group resource belongs |

# The Terraform module of HUAWEI Cloud VPC service

What capabilities does the current Module provide:

- One-click deployment of VPC and related resources.
- Use the resource's name to query the resource's ID by data-sources.

## Usage

### Create a VPC and two subnets, no security group

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

### Query resource IDs using resource names

```hcl
module "vpc_service" {
  source = "terraform-huaweicloud-modules/vpc-service"

  query_vpc_names            = ["module-single-vpc"]
  query_subnet_names         = ["module-single-master-subnet", "module-single-standby-subnet"]
  query_security_group_names = ["module-single-security-group"]
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
| huaweicloud_vpc_address_group.this | resource |
| huaweicloud_networking_secgroup_rule.remote_address_group | resource |
| data.huaweicloud_vpcs.this | data-source |
| data.huaweicloud_vpc_subnets.this | data-source |
| data.huaweicloud_networking_secgroups.this | data-source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| enterprise_project_id | Used to specify whether the resource is created under the enterprise project (this parameter is only valid for enterprise users) | string | null | N |
| name_suffix | The suffix string of name for all Network resources | string | "" | N |
| is_vpc_create | Controls whether a VPC should be created (it affects all VPC related resources under this module) | bool | true | N |
| vpc_name | The name of the VPC resource | string | "" | N |
| vpc_cidr_block | The CIDR block of the VPC resource | string | "192.168.0.0/16" | N |
| subnets_configuration | The configuration for the subnet resources to which the VPC belongs | <pre>list(object({<br>  name           = string<br>  description    = optional(string, null)<br>  cidr           = string<br>  ipv6_enabled   = optional(bool, true)<br>  dhcp_enabled   = optional(bool, true)<br>  dns_list       = optional(list(string), null)<br>  tags           = optional(map(string), {})<br>  delete_timeout = optional(string, null)<br>}))</pre> | <pre>[<br>  {<br>    name = "module-default-subnet",<br>    cidr = "192.168.16.0/20",<br>  },<br>]</pre> | N |
| is_security_group_create | Controls whether a security group should be created (it affects all security group related resources under this module) | bool | true | N |
| security_group_name | The name of the security group resource" | string | "" | N |
| security_group_description | The description of the security group resource | string | null | N |
| security_group_rules_configuration | The configuration for security group rule resources to which the security group belongs | <pre>list(object({<br>  description             = optional(string, null)<br>  direction               = optional(string, "ingress")<br>  ethertype               = optional(string, "IPv4")<br>  protocol                = optional(string, null)<br>  ports                   = optional(string, null)<br>  remote_ip_prefix        = optional(string, "0.0.0.0/0")<br>  remote_group_id         = optional(string, null)<br>  remote_address_group_id = optional(string, null)<br>  action                  = optional(string, "allow")<br>  priority                = optional(number, null)<br>}))</pre> | <pre>[<br>  {<br>    protocol = "icmp"<br>  }<br>]</pre> | N |
| remote_address_group_rules_configuration | The configuration of remote address group for security group rule resources | <pre>list(object({<br>  description      = optional(string, null)<br>  direction        = optional(string, "ingress")<br>  ethertype        = optional(string, "IPv4")<br>  protocol         = optional(string, null)<br>  ports            = optional(string, null)<br>  remote_addresses = list(string)<br>  action           = optional(string, "allow")<br>  priority         = optional(number, null)<br>}))</pre> |<pre>[<br>  {<br>    direction        = "ingress",<br>    ethertype        = "IPv4",<br>    protocol         = "icmp",<br>    ports            = "80",<br>    remote_addresses = ["192.168.10.22,192.168.11.0-192.168.11.240"],<br>  }<br>]<pre> | N |
| query_vpc_names | The VPC name list used to query the resource IDs | list(string) | <pre>[]</pre> | N |
| query_subnet_names | The subnet name list used to query the resource IDs | list(string) | <pre>[]</pre> | N |
| query_security_group_names | The security group name list used to query the resource IDs | list(string) | <pre>[]</pre> | N |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC resource |
| vpc_cidr | The CIDR block of the VPC resource |
| subnet_cidrs | The CIDR list of the subnet resources to which the VPC resource belongs |
| subnet_ids | The ID list of the subnet resources to which the VPC resource belongs |
| security_group_id | The ID of the security group resource |
| security_group_rules | All rules to which the security group resource belongs |
| query_vpc_ids | The ID list of the VPC resources for data-source query by resource name |
| query_subnet_ids | The ID list of the subnet resources for data-source query by resource name |
| query_security_group_ids | The ID list of the security group resources for data-source query by resource name |

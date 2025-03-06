<!-- markdownlint-disable MD041 -->
## 1.2.0

Adjust the resource examples and supports more scenes.
Fix resource (also includes variable and output) coding with wrong format or some definitions are missing.

FEATURES:

<!-- markdownlint-disable MD013 -->
+ **Examples adjustment:** More examples are supported ([#16](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/16))
<!-- markdownlint-enable MD013 -->

FIXED:

<!-- markdownlint-disable MD013 -->
+ **Missing reference:** Supplement the missing reference of the parameter 'remote_address_group_id' for the security group rule resource ([#15](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/15))
+ **Missing variable:** Supplement the variable definition of the parameter 'availability_zones' ([#23](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/23))
<!-- markdownlint-enable MD013 -->

## 1.1.0

Supporting security group rules creation for remote group and remote address group.
Supporting the documentation to guide customers on using the module.

FEATURES:

<!-- markdownlint-disable MD013 -->
+ **Resources querying:** Support three data-sources to query resource ID according to their names ([#10](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/10))
+ **Example of resources querying:** ([#11](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/11))
+ **New security group rules:** Support `remote_group_id` and `remote_address_group_id` arguments and related introduction ([#12](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/12))
+ **Example of security group rules:**: Support related documentation ([#13](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/13))
<!-- markdownlint-enable MD013 -->

## 1.0.0 (Repository Build)

The first release version.
Support the VPC module to manage VPC and related resources:

+ VPC
+ Subnet
+ Security group
+ Security group rule

FEATURES:

<!-- markdownlint-disable MD013 -->
+ **New Gatekeeper:** Style check for PR title and documentation ([#4](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/4))
+ **New Introduction:** Support EADME file, first resource's script and example ([#6](https://github.com/terraform-huaweicloud-modules/terraform-huaweicloud-vpc/pull/6))
<!-- markdownlint-enable MD013 -->

# VPC basic example

Configuration in this directory creates VPC and VPC Subnet.

## Usage
To run this example you need first replace the configuration like name, subnets,etc, with your own resource and execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Outputs

| Name | Description |
|------|-------------|
| this_vpc_id | The ID of the VPC |
| this_subnet_ids | List of IDs of the Subnets |
| this_network_ids | List of Network IDs of the Subnets |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

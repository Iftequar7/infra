AWS VPC Configuration

This repository contains Terraform code for configuring an Amazon Web Services (AWS) Virtual Private Cloud (VPC), an Internet Gateway, and public and private subnets.
Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

First, create a module file in the root directory and add the values of the following variables:

# VPC Module #################################################
```
module "vpc" {

  source                = "./modules/vpc"
  region                = local.region
  vpc-cidr              = "10.154.0.0/21"
  vpc-name              = "egress-vpc"
  project_name          = "egress"
  
  subnet_cidr_block_pub = [
    "10.154.0.0/25",
    "10.154.0.128/25",
    "10.154.1.0/25"
  ]
  
  availability_zone_pub = [
     "${local.region}a",
    "${local.region}b",
    "${local.region}c"
  ]

  subnet_name_map_pub = {
    "10.154.0.0/25"   = "egress-access-public-subnet-a"
    "10.154.0.128/25"  = "egress-access-public-subnet-b"
    "10.154.1.0/25" = "egress-access-public-subnet-c"
  }

  subnet_cidr_block_pvt = [
    "10.154.1.128/25",
    "10.154.2.0/25",
    "10.154.2.128/25"
  ]
  
  availability_zone_pvt = [
     "${local.region}a",
    "${local.region}b",
    "${local.region}c"
  ]

  subnet_name_map_pvt = {
     "10.154.1.128/25"   = "egress-tgw-private-subnet-a"
    "10.154.2.0/25"  = "egress-tgw-private-subnet-b"
    "10.154.2.128/25" = "egress-tgw-private-subnet-c"
  }

}
```

Getting Started

To get started, clone this repository to your local machine and navigate to the root directory. Then, run the following command to initialize the Terraform configuration:

terraform init

These variables will be used to configure the VPC, Internet Gateway, and subnets.

Finally, run the following command to apply the Terraform configuration:

terraform apply

This will create the VPC, Internet Gateway, and subnets in your AWS account.
Outputs

After running the terraform apply command, you can use the following outputs to retrieve the IDs of the resources created:

    vpc_id: The ID of the VPC
    igw_id: The ID of the Internet Gateway
    public_subnet_ids: The IDs of the public subnets
    private_subnet_ids: The IDs of the private subnets

Cleaning Up

To delete the resources created by this Terraform configuration, run the following command:

terraform destroy

This will delete the VPC, Internet Gateway, and subnets from your AWS account.
License

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 4.0.0 |
| aws | >= 2.46 |

## Inputs
| Name | Description | Type	| Default | Required |
|------|-------------|------|---------|----------|
| vpc-cidr | The CIDR block for the VPC. | string | n/a | yes |
| vpc-name | The name of the VPC. |	string | n/a | yes |
| subnet_cidr_block_pub | A list of CIDR blocks for the public subnets. | list(string) | n/a | yes |
| subnet_cidr_block_pvt | A list of CIDR blocks for the private subnets. | list(string) | n/a | yes |
| availability_zone_pub	| A list of availability zones for the public subnets. | list(string) |	n/a | yes |
| availability_zone_pvt | A list of availability zones for the private subnets. | list(string) | n/a | yes |
| subnet_name_map_pub |	A map of subnet CIDR blocks to subnet names for the public subnets. | map(string) |	n/a | yes |
| subnet_name_map_pvt |	A map of subnet CIDR blocks to subnet names for the private subnets. | map(string) | n/a | yes |

## Outputs
| Name | Description |
|-----|-------------|
| vpc_id | The ID of the VPC. |
| public_subnet_ids	| The IDs of the public subnets. |
| private_subnet_ids | The IDs of the private subnets. |
| internet_gateway_id | The ID of the internet gateway. |
| nat_gateway_ids | The IDs of the NAT gateways. |



This Terraform configuration is released under the MIT License.


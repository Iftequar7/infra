AWS VPC Configuration

This repository contains Terraform code for configuring an Amazon Web Services (AWS) Virtual Private Cloud (VPC), an Internet Gateway, and public and private subnets.
Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

First, create a module file in the root directory and add the values of the following variables:

# VPC Module ########################################################################################################
```
module "orch_vpc" {
  source = "../../../modules/terraform-aws-vpc" # vpc module repo url

  vpc_cidr_block = "10.154.32.0/21"
  vpc_name       = "orchestration-vpc"

  create_public_subnet = false
  
  ############################################ Private subnets configuration #######################################
  create_private_subnet = true
  private_subnet_count  = 6
  private_subnet_cidr_block = [
    "10.154.32.0/25", "10.154.32.128/25", "10.154.33.0/25",
    "10.154.33.128/25", "10.154.34.0/25", "10.154.34.128/25"
  ]
  private_subnet_az = [
    "${local.region}a", "${local.region}b", "${local.region}c",
    "${local.region}a", "${local.region}b", "${local.region}c"
  ]
  private_subnet_name_map = {
    "10.154.32.0/25"   = "orchestration-eks-private-subnet-a",
    "10.154.32.128/25" = "orchestration-eks-private-subnet-b",
    "10.154.33.0/25"   = "orchestration-eks-private-subnet-c",
    "10.154.33.128/25" = "orchestration-tgw-private-subnet-a",
    "10.154.34.0/25"   = "orchestration-tgw-private-subnet-b",
    "10.154.34.128/25" = "orchestration-tgw-private-subnet-c"
  }

  ############################################## Internet Gateway Configuration ######################################
  create_igw = false

  ############################################## NAT Gateway Configuration update ####################################
  create_nat_gateway        = false
  create_nat_gateway_per_az = false

  
  ############################################# Create the route tables as per vpc ###################################
  create_igw_public_rt = false
  create_natgtw_private_rt = false

}
```

Getting Started

To get started, clone this repository to your local machine and navigate to the root directory. Then, run the following command to initialize the Terraform configuration:

```
terraform init
terraform plan
```

These variables will be used to configure the VPC, Internet Gateway, and subnets.

Finally, run the following command to apply the Terraform configuration:

```
terraform apply -auto-approve
```

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


## Resources
| Name | Description |
|-----|-------------|
| aws_vpc | Configures the VPC resource. |
| aws_subnet | Configures public and private subnets. |
| aws_internet_gateway | Configures the internet gateway for public subnets. |
| aws_eip | Configures Elastic IPs for NAT gateways. |
| aws_nat_gateway | Configures NAT gateways for private subnets. |
| aws_route_table | Configures route tables for public and private subnets. |
| aws_route_table_association | Associates subnets with route tables. |
| aws_route | Configures routes for internet and NAT gateways. |


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
| vpc_details | VPC details like ID, ARN, CIDR etc of our VPC. |
| vpc_arn | ARN of our VPC. |
| public_subnet_details | Public Subnet details like NAME, CIDR_Block, AZ, ID of all Public Subnets. |
| private_subnet_details | Private Subnet details like NAME, CIDR_Block, AZ, ID of all Private Subnets. |
| nat_gateway_details | The IDs of the NAT gateways. |
| internetgw_details | The IDs of the Internet gateways. |
| private_subnet_arn | ARN of the Private Subnets. |


This Terraform configuration is released under the MIT License.


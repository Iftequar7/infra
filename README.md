AWS VPC Configuration

This repository contains Terraform code for configuring an Amazon Web Services (AWS) Virtual Private Cloud (VPC), an Internet Gateway, and public and private subnets.
Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

### First, create a module file in the root directory and add the values of the following variables:

Kindly replace the values from the module given below.

* To create Public or Private subnets, set the value to true or false accordingly. If set to false, the subnets will not be created.

* Specify the number of subnets you want to create by setting the value of public_subnet_count or private_subnet_count.

* Choose the CIDR range for your subnets by setting the values of public_subnet_cidr_block and private_subnet_cidr_block.

* Give names to your subnets by specifying the CIDR range of each subnet in public_subnet_name_map or private_subnet_name_map.

* Configure the Internet Gateway by setting the value of create_igw to true or false. If set to false, the Internet Gateway will not be created.

* Similarly, configure the NAT Gateway by setting the value of create_nat_gateway to true or false. If you need a NAT Gateway in each Availability Zone, set create_nat_gateway_per_az to true.

* To create routes for Internet Gateway and NAT Gateway, set the values of create_igw_public_rt and create_natgtw_private_rt to true or false, as required.

# VPC Module ########################################################################################################
```
module "module_name" {
  source = "../../../modules/terraform-aws-vpc" # vpc module repo url
  
  vpc_cidr_block = "10.0.0.0/16" # specify your VPC CIDR range
  vpc_name       = "name-vpc" # specify VPC name

  ################################### Public subnets inputs & configuration  ################################################
  create_public_subnet     = true
  public_subnet_count      = 3 
  public_subnet_cidr_block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnet_az         = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnet_name_map   = { "10.0.1.0/24" = "public-subnet-a", "10.0.2.0/24" = "public-subnet-b", "10.0.3.0/24" = "public-subnet-c" }

  # Private subnets inputs
  create_private_subnet     = true
  private_subnet_count      = 3
  private_subnet_cidr_block = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  private_subnet_az         = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnet_name_map   = { "10.0.4.0/24" = "private-subnet-a", "10.0.5.0/24" = "private-subnet-b", "10.0.6.0/24" = "private-subnet-c" }

  ##################################### Internet Gateway Configuration #######################################################
  create_igw = true

  ##################################### NAT Gateway Configuration ############################################################
  create_nat_gateway        = false
  create_nat_gateway_per_az = false

####################################### Create the route tables as per vpc ###################################################
  create_igw_public_rt = true
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


## Inputs
**Note:** All inputs with Yes under the **Required** column are mandatory to execute the Terraform module successfully.
| Name | Description | Type	| Default | Required |
|------|-------------|------|---------|----------|
| vpc_cidr_block | The CIDR block for the VPC. | string | n/a | yes |
| vpc_name | The name of the VPC. |	string | n/a | yes |
| create_public_subnet | Boolean variable to create Public subnets. | bool | false | yes |
| public_subnet_count | The number of Public subnets to create. | number | 0 | yes |
| public_subnet_cidr_block | A list of CIDR blocks for the Public subnets. | list(string) |	null | yes |
| public_subnet_az | A list of availability zones for the Public subnets. | list(string) | null | yes |
| public_subnet_name_map | A map of names for the public subnets. | map(string) | null | yes |
| create_private_subnet | Boolean variable to create private subnets. | bool | false | yes |
| private_subnet_count | The number of private subnets to create. | number | 0 | yes |
| private_subnet_cidr_block | A list of CIDR blocks for the private subnets. | list(string) | null | yes |
| private_subnet_az | A list of availability zones for the private subnets. | list(string) | null | yes |
| private_subnet_name_map |	A map of names for the private subnets. | map(string) | null | yes |
| create_igw | Boolean variable to create an internet gateway for public subnets. | bool | false | yes |
| create_nat_gateway | Boolean variable to create NAT gateways for private subnets. | bool | false | yes |
| create_nat_gateway_per_az | Boolean variable to create one NAT gateway per availability zone. | bool | false | yes |
| create_igw_public_rt | Boolean variable to create a public route table for public subnets. | bool | false | yes |
| create_natgtw_private_rt | Boolean variable to create private route tables for NAT gateways. | bool | false | yes |


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


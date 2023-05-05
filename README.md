AWS Transit Gateway Configuration

This repository contains Terraform code for configuring an Amazon Web Services (AWS) Transit Gateway.

Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

### First, create a module file in the root directory and add the values of the following variables:

Kindly replace the values from the module given below.

    1. Set the region to your desired AWS region in the region parameter.

    2. Configure the Transit Gateway by setting the following parameters:
        * create_tgw: Set to true to create a new Transit Gateway.
        * name: Name of the Transit Gateway.
        * amazon_side_asn: Amazon side Autonomous System Number (ASN).
        * description: Description of the Transit Gateway.
        * enable_default_route_table_association: Set to false to disable association with the default route table.
        * enable_default_route_table_propagation: Set to false to disable propagation to the default route table.
        * enable_auto_accept_shared_attachments: Set to true to automatically accept shared VPC attachments.
        * enable_dns_support: Set to true to enable DNS support.

    3. Configure Resource Sharing by setting the following parameters:
        * allow_external_principals: Set to true to allow sharing with external accounts.
        * resource_share_accounts: List of AWS account IDs to share the Transit Gateway with.
        * tags: A map of tags to add to the resource share.
        * share_tgw: Set to true to share the Transit Gateway.

    4. Configure VPC Attachments by setting the following parameters for each attachment:
        * vpc_id_X: ID of the VPC.
        * subnet_ids_X: List of IDs of the subnets in the VPC.
        

# VPC Module ########################################################################################################
```
module "tgw" {
  source = "../../terraform-aws-transit-gateway"
  region = "eu-central-1"
  # create_tgw = true
  name   = "networking-tgw-01"
  amazon_side_asn         = "64512"
  description             = "This is Transit Gaaateway"
  enable_default_route_table_association    = false
  enable_default_route_table_propagation    = false
  enable_auto_accept_shared_attachments     = true
  enable_dns_support                        = true

######################################################### RAM resource share ########################################
allow_external_principals = true
resource_share_accounts = ["111111111111", "222222222222"] 
  tags = {
    Name = "tgw-resource-share"
  }

share_tgw = true

####################################### Vpc attachments ##############################################################

# ---------------------------------------------------- Transit Gatewaw vpc_1 attachment ------------------------------

  vpc_id_1                  =  "vpc-0d2e6e67a3c1aad38"
  subnet_ids_1              = ["subnet-0271d46555e756204", "subnet-0748daf7d1acf68dd", "subnet-0f6356b48d5683d0f"] 
  attachment1_name          = "name_1-to-tgw01"

# ---------------------------------------------------- Transit Gatewaw vpc_2 attachment ------------------------------

  vpc_id_2                  =  "vpc-0dda0cd4027ddface"
  subnet_ids_2              = ["subnet-0a3e445e5d0773496", "subnet-0c0d7a16f755ea570", "subnet-0bacdcfbddcea4fb4"]
  attachment2_name          = "name_2-to-tgw01"

 # ---------------------------------------------------- Transit Gatewaw vpc_3 attachment -----------------------------
 
  vpc_id_3                  = "vpc-061171ef1a7670ca6"
  subnet_ids_3              = ["subnet-013ae547208a6438f", "subnet-00e35c66452539875", "subnet-08640a3b1da20da9f"]
  attachment3_name          = "name_3-to-tgw01"

# ---------------------------------------------------- Transit Gatewaw vpc_4 attachment ------------------------------

  vpc_id_4                 = "vpc-0306b35e4ab042334"
  subnet_ids_4             = ["subnet-0134c9f92f8e06e46", "subnet-0a069ce5dfc9ea22f", "subnet-00961c796e81c9126"]
  attachment4_name         = "name_4-to-tgw01"
}
```

Getting Started

To get started, clone this repository to your local machine and navigate to the root directory. Then, run the following command to initialize the Terraform configuration:

```
terraform init
terraform plan
```

These values will be used to configure the Transit Gateway, and Resource Access Manager.

Finally, run the following command to apply the Terraform configuration:

```
terraform apply -auto-approve
```

This will create the Transit Gateway, and Resource Access Manager in your AWS account to communicate with VPC's on other AWS accounts.

Outputs

After running the terraform apply command, you can use the following outputs to retrieve the IDs of the resources created:

    tgw_id: This output provides the ID of the AWS Transit Gateway created by this module
    tgw_arn: This output provides the ARN (Amazon Resource Name) of the AWS Transit Gateway created by this module
    tgw_share_arn: This output provides the ARN (Amazon Resource Name) of the created RAM (Resource Access Manager) resource share
                   The resource share allows the specified accounts to use the created AWS Transit Gateway
    

Cleaning Up

To delete the resources created by this Terraform configuration, run the following command:

```
terraform destroy
```

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
| region | The region where the transit gateway should be created. | string | "" | yes |
| name | The name for the transit gateway. | string | "" | yes |
| amazon_side_asn | The private ASN for the Amazon side of the transit gateway. | string | "" | yes |
| description | A description for the transit gateway. | string | "" | yes |
| enable_default_route_table_association | Enable association of the default route table with the transit gateway. | bool |	false | yes |
| enable_default_route_table_propagation | Enable propagation of the default route table to the transit gateway. | bool | false | yes |
| enable_auto_accept_shared_attachments | Enable auto acceptance of shared attachments. | bool | true | yes |
| enable_dns_support | Enable DNS support for the transit gateway. | bool | true | yes |
| allow_external_principals | TWhether to allow external AWS accounts to use resources shared through Resource Access Manager (RAM). | bool | true | yes |
| resource_share_accounts | A list of AWS account IDs to share the transit gateway with. | list(string) | [] | yes |
| tags | A map of tags to assign to the transit gateway. | map(string) | {} | yes |
| share_tgw | Whether to share the transit gateway through Resource Access Manager (RAM). | bool | true | yes |
| vpc_id_1 | The ID of the VPC_1 to attach to the transit gateway. | string | null | yes |
| subnet_ids_1 | A list of subnet IDs in the VPC_1 to attach to the transit gateway. | list(string) | [] | yes |
| attachment1_name | The name for the attachment between the VPC_1 and the transit gateway. | string | "" | yes |
| vpc_id_2 | The ID of the VPC_2 to attach to the transit gateway. | string | null | yes |
| subnet_ids_2 | A list of subnet IDs in the VPC_2 to attach to the transit gateway. | list(string) | [] | yes |
| attachment2_name | The name for the attachment between the VPC_2 and the transit gateway. | string | " " | yes |
| vpc_id_3 | The ID of the VPC_3 to attach to the transit gateway. | string | null | yes |
| subnet_ids_3 | A list of subnet IDs in the VPC_3 to attach to the transit gateway. | list(string) | [] | yes |
| attachment3_name | The name for the attachment between the VPC_3 and the transit gateway. | string | " | yes |
| vpc_id_4 | The ID of the VPC_4 to attach to the transit gateway. | string | null | yes |
| subnet_ids_4 | A list of subnet IDs in the VPC_4 to attach to the transit gateway. | list(string) | [] | yes |
| attachment4_name | The name for the attachment between the VPC_4 and the transit gateway. | string | "" | yes |


## Resources
| Name | Description |
|-----|-------------|
| aws_ec2_transit_gateway | Manages an AWS Transit Gateway. |
| aws_ec2_transit_gateway_vpc_attachment | Attaches a VPC to an AWS Transit Gateway. |
| aws_ec2_transit_gateway_route_table | Manages a Transit Gateway Route Table. |
| aws_ec2_transit_gateway_route | Manages a Transit Gateway Route. |
| aws_ram_resource_share | Manages a Resource Share in AWS RAM. |
| aws_ram_principal_association | Manages the association between RAM Share and Principal. |
| aws_ram_resource_association | Manages the association between RAM Share and Resources. |
| aws_caller_identity | Provides the AWS Account ID and other details. |
| aws_ram_resource_share_accepter | Manages the acceptance of a Resource Share in AWS RAM. |


## Outputs
| Name | Description |
|-----|-------------|
| tgw_id | The ID of the created AWS Transit Gateway. |
| tgw_arn | The ARN of the created AWS Transit Gateway. |
| tgw_share_arn | The ARN of the created RAM resource share. |


This Terraform configuration is released under the MIT License.


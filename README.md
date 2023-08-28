AWS Security Group Terraform Configuration

This repository contains Terraform code for configuring the Amazon Web Services (AWS) Security Group.

Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

### First, create a module file in the root directory and add the values of the following variables:

You can customise the Security Group configuration by providing values for the following variables in your module:

    1. Set the region to your desired AWS region in the region parameter.
              

# Security Group Module ########################################################################################################
```
module "security_groups" {
  source = "git::https://github.com/NDB-ro/terraform-aws-security-group.git"

  vpc_id = "vpc-xxxxxxxxxxxxxxxxx"
  security_groups = [
    {
      name        = "orchestration-montran-dev-efs"
      description = "Security group to restrict Montran EFS"

      custom_inbound_rules = [
        {
          from_port         = 2049
          to_port           = 2049
          protocol          = "tcp"
          cidr_blocks       = ["10.154.32.0/25", "10.154.32.128/25", "10.154.33.0/25"]
          security_group_id = null
          self              = false
        }
      ]
      custom_outbound_rules = [
        {
          from_port         = 0
          to_port           = 0
          protocol          = -1
          cidr_blocks       = ["0.0.0.0/0"]
          security_group_id = null
          self              = false
        }
      ]
    },
    {
      name        = "orchestration-montran-dev-rds"
      description = "Security group to restrict Montran RDS"
      custom_inbound_rules = [
        {
          from_port         = 5432
          to_port           = 5432
          protocol          = "tcp"
          cidr_blocks       = ["10.154.32.0/25", "10.154.32.128/25", "10.154.33.0/25"]
          security_group_id = null
          self              = false
        }
      ]
      custom_outbound_rules = [
        {
          from_port         = 0
          to_port           = 0
          protocol          = -1
          cidr_blocks       = ["0.0.0.0/0"]
          security_group_id = null
          self              = false
        }
      ]
    }
  ]
}
```

Getting Started

To get started, clone this repository to your local machine and navigate to the root directory. Then, run the following command to initialize the Terraform configuration:

```
terraform init
terraform plan
```

These values will be used to configure the Security Group, and Resource Access Manager.

Finally, run the following command to apply the Terraform configuration:

```
terraform apply -auto-approve
```

This will create the Security Group on AWS accounts.

Outputs

After running the terraform apply command, you can use the following outputs to retrieve the IDs of the resources created:

    security_group_ids: IDs of the created security groups.    

Cleaning Up

To delete the resources created by this Terraform configuration, run the following command:

```
terraform destroy
```

This will delete the Security Group from your AWS account.


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 4.0.0 |
| aws | >= 2.46 |


## Inputs
**Note:** All inputs with Yes under the **Required** column are mandatory to execute the Terraform module successfully.
| Name | Description | Type	| Default | Required |
|------|-------------|------|---------|----------|
| vpc_id | The ID of the VPC where the security groups will be created. | string | ```""``` | yes |
| name | A name for the security group. | string | ```""``` | yes |
| description | A description of the security group. | string | ```""``` | yes |
| custom_inbound_rules | Custom inbound rules to control incoming traffic. | list(object) | ```('','')``` | yes |
| custom_outbound_rules | Custom outbound rules to manage outgoing traffic. | list(object) | ```('','')``` | yes |
| from_port | The starting port for the rule. | number | ```""``` | yes |
| to_port | The ending port for the rule. | number | ```""``` | yes |
| protocol | The protocol of the rule (e.g., "tcp"). | string | ```""``` | yes |
| cidr_blocks | List of CIDR blocks to allow traffic from/to. | list(string) | ```("")``` | yes |
| security_group_id | ID of another security group to allow traffic from/to. | string | ```""``` | yes |
| self | Boolean indicating if the security group itself is allowed to communicate on this rule. | bool | ```false``` | yes |


## Resources
| Name | Description |
|-----|-------------|
| aws_security_group | Manages the creation and lifecycle of the security groups. |


## Outputs
| Name | Description |
|-----|-------------|
| security_group_ids | IDs of the created security groups |


This Terraform configuration is released under the MIT License.


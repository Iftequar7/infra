AWS RDS Database Terraform Configuration

This repository contains Terraform code for configuring the Amazon Web Services (AWS) RDS database.

Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

### First, create a module file in the root directory and add the values of the following variables:

You can customise the RDS database cluster configuration by providing values for the following variables in your module:

    1. Set the region to your desired AWS region in the region parameter.
              

# RDS database cluster Module ########################################################################################################
```
module "montran_rds_dev" {
  source = "git::https://github.com/NDB-ro/terraform-aws-montran-rds.git"  

  name                                    = "montran-rds-dev"
  template                                = "dev/test"
  dbname                                  = "montrandb"
  engine                                  = "postgres"
  engine_version                          = "14.6" # Change this based on the latest supported version
  enable_auto_minorversion_upgrade        = false
  instance_size                           = "db.r5.large"
  multi_az                                = true  # Enable Multi-AZ deployment
  performance_insights                    = true
  performance_insights_key                = "arn:aws:kms:eu-central-1:962491557115:key/18977c2e-0aa4-4831-9e8e-66cd3790bcfa"
  insights_retention_period               = "7"
  storage_encrypted                       = true
  kms_keyid                               = "arn:aws:kms:eu-central-1:962491557115:key/18977c2e-0aa4-4831-9e8e-66cd3790bcfa"
  monitoring_interval                     = "60"
  monitoring_role_arn                     = "arn:aws:iam::962491557115:role/rds-monitoring-role"
  final_snapshot_name                     = "montran-rds-dev-snapshot"
  private_subnet_group                    = "orchestration-dev-vpc-subnets"
  private_subnets                         = ["subnet-0cf1d862e6a9be7ac", "subnet-01582f94906c829bd", "subnet-0985572714c377918"]
  allocated_storage                       = 100
  max_allocated_storage                   = 1000
  /*schemas                               = ["gps", "mp_0", "mp_1", "mp_"] */
  authentication                          = "Password and IAM"
  security_group                          = "sg-031475008ef99f75f"
  iam_role                                = "iam-dev-montran-readwrite"
  master_username                         = var.master_username  # variable type sensitive so pass input values using -var when performing terraform plan  & apply
  master_password                         = var.master_password  # variable type sensitive so pass input values using -var when performing terraform plan & apply
}
```

Getting Started

To get started, clone this repository to your local machine and navigate to the root directory. Then, run the following command to initialize the Terraform configuration:

```
terraform init
terraform plan
```

These values will be used to configure the RDS database cluster, and Resource Access Manager.

Finally, run the following command to apply the Terraform configuration:

```
terraform apply -auto-approve
```

This will create the RDS database cluster on AWS accounts.

Outputs

After running the terraform apply command, you can use the following outputs to retrieve the IDs of the resources created:

    instance_id: The ID of the created EC2 instance.
    public_ip: The public IP address of the created EC2 instance.
    

Cleaning Up

To delete the resources created by this Terraform configuration, run the following command:

```
terraform destroy
```

This will delete the Transit Gateway, and Resource Access Manager from your AWS account.


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 4.0.0 |
| aws | >= 2.46 |


## Inputs
**Note:** All inputs with Yes under the **Required** column are mandatory to execute the Terraform module successfully.
| Name | Description | Type	| Default | Required |
|------|-------------|------|---------|----------|
| name | A name for the RDS instance. | string | ```""``` | yes |
| template | A template for naming the RDS resources (e.g., "dev/test"). | string | ```""``` | yes |
| dbname | The name of the database to be created. | string | ```""``` | yes |
| engine | The database engine to use (e.g., "postgres"). | string | ```""``` | yes |
| engine_version | The version of the database engine. | string |	```""``` | yes |
| enable_auto_minorversion_upgrade | Whether to enable automatic minor version upgrades. | bool | ```false``` | yes |
| instance_size | The instance size for the RDS instance. | string | ```""``` | yes |
| multi_az | Whether to enable Multi-AZ deployment. | bool | ```true``` | yes |
| performance_insights | Whether to enable Performance Insights. | bool | ```true``` | yes |
| performance_insights_key | The KMS key ID for Performance Insights. | string | ```""``` | yes |
| insights_retention_period | The retention period for Performance Insights data. | string | ```""``` | yes |
| storage_encrypted | Whether to enable storage encryption. | bool | ```true``` | yes |
| kms_keyid | The KMS key ID for storage encryption. | string | ```""``` | yes |
| monitoring_interval | The monitoring interval for the instance. | string | ```""``` | yes |
| monitoring_role_arn | TThe ARN of the IAM role for monitoring. | string | ```""``` | yes |
| final_snapshot_name | The name for the final snapshot during instance deletion. | string | ```""``` | yes |
| private_subnet_group | The name of the private subnet group. | string | ```""``` | yes |
| private_subnets | List of private subnet IDs to launch the instance in. | string | ```""``` | yes |
| allocated_storage | The initial allocated storage in GB. | string | ```""``` | yes |
| max_allocated_storage | The maximum allocated storage in GB. | string | ```""``` | yes |
| authentication | Authentication method (e.g., "Password and IAM"). | string | ```""``` | yes |
| security_group | The security group ID for the instance. | string | ```""``` | yes |
| iam_role | The IAM role for the instance. | string | ```""``` | yes |
| master_username | The master username for the instance. | string | ```""``` | yes |
| master_password | The master password for the instance. | string | ```""``` | yes |


## Resources
| Name | Description |
|-----|-------------|
| aws_db_subnet_group | Manages an AWS Subnet Security. |
| aws_db_instance | Manages the creation and lifecycle of the RDS instance. |


## Outputs
| Name | Description |
|-----|-------------|
| rds_endpoint | The endpoint of the RDS instance |


This Terraform configuration is released under the MIT License.


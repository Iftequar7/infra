AWS EC2 Instance Terraform Configuration

This repository contains Terraform code for configuring an Amazon Web Services (AWS) EC2 instances.

Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

### First, create a module file in the root directory and add the values of the following variables:

Kindly replace the values from the module given below.

    1. Set the region to your desired AWS region in the region parameter.

    2. Configure the EC2 instances by setting the following parameters:
        * instance_count: Number of EC2 instances to create.
        * ami: ID of the Amazon Machine Image (AMI) to use.
        * availability_zone: Availability zone where the instance(s) will be launched.
        * instance_type: Type of EC2 instance to launch.
        * user_data_file: Path to the user data script file for instance customization.
        * iam_role_name: Name of the IAM role to associate with the instance(s).
        * associate_public_ip_address: Whether to associate a public IP address.
        * subnet_id: ID of the subnet in which to launch the instance(s).
        * private_ip: Private IP address for the instance(s).
        * vpc_security_group_ids: List of security group IDs to associate.
        * root_volume_type: Type of root volume (e.g., "gp2").
        * root_volume_size: Size of the root volume in gigabytes.
        * root_iops: IOPS for root volume (only applicable for provisioned IOPS volumes).
        * root_throughput: Throughput for root volume (only applicable for throughput-optimized HDD volumes).
        * volume_delete_on_termination: Whether to delete the volume on instance termination.
        * root_block_device_encrypted: Whether the root block device should be encrypted.
        * root_block_device_kms_key_id: KMS key ID for root block device encryption.
        * name: Name tag for the instance(s).
        * policy_document: IAM policy document for the instance role.
        * policy_name: Name for the IAM policy.
              

# EC2 Instance Module ########################################################################################################
```
module "ec2-module" {
  source = "git::https://github.com/NDB-ro/terraform-aws-ec2-module.git"
  instance_count                       = var.instance_count
  ami                                  = var.ami
  availability_zone                    = var.availability_zone
  instance_type                        = var.instance_type
  user_data_file                       = var.user_data_file
  iam_role_name                        = var.iam_role_name
  associate_public_ip_address          = var.associate_public_ip_address
  subnet_id                            = var.subnet_id
  private_ip                           = var.private_ip
  vpc_security_group_ids               = var.vpc_security_group_ids
  root_volume_type                     = var.root_volume_type
  root_volume_size                     = var.root_volume_size
  root_iops                            = var.root_iops
  root_throughput                      = var.root_throughput
  volume_delete_on_termination         = var.volume_delete_on_termination
  root_block_device_encrypted          = var.root_block_device_encrypted
  root_block_device_kms_key_id         = var.root_block_device_kms_key_id
  name                                 = var.name
  policy_document                      = var.policy_document
  policy_name                          = var.name
  
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
| region | The region where the transit gateway should be created. | string | ```""``` | yes |
| instance_count | The number of instances to create. | number | ```1``` | yes |
| ami | The Amazon Machine Image (AMI) to use for the instance. | string | ```ami-0122fd36a4f50873a``` | yes |
| availability_zone | The availability zone in which to launch the instance. | string | ```eu-central-1a``` | yes |
| instance_type | The instance type (e.g., t2.micro, m5.large). | string |	```t2.medium``` | yes |
| user_data_file | Path to the user data script to run when launching the instance. | string | ```./script.sh``` | yes |
| iam_role_name | The name of the IAM role to associate with the instance. | string | ```iam-dev-ec2-sessionhost-appCICD``` | yes |
| associate_public_ip_address | Whether to associate a public IP address with the instance. | bool | ```false``` | yes |
| subnet_id | The ID of the subnet in which to launch the instance. | string | ```subnet-025159d8647f3fb75``` | yes |
| private_ip | The private IP address for the instance. | string | ```null``` | yes |
| vpc_security_group_ids | List of security group IDs to associate with the instance. | list(string) | ```sg-037aab42aba350aa2``` | yes |
| root_volume_type | The type of root volume (e.g., gp2, io1). | string | ```gp3``` | yes |
| root_volume_size | The size of the root volume in gigabytes. | number | ```10``` | yes |
| root_iops | The IOPS for the root volume (only for io1 volumes). | number | ```3000``` | yes |
| root_throughput | The throughput for the root volume (only for io1 volumes). | number | ```125``` | yes |
| volume_delete_on_termination | Whether to delete the root volume on instance termination. | bool | ```true``` | yes |
| root_block_device_encrypted | Whether the root block device is encrypted. | bool | ```true``` | yes |
| root_block_device_kms_key_id | The KMS key ID for encrypting the root block device. | string | ```null``` | yes |
| name | The name of the EC2 instance. | string | ```ec2-sharedservices-dev-sessionhost-appCICD``` | yes |
| policy_document | The policy document for an IAM role. | string | ```policy.json``` | yes |
| policy_name | The name of the policy. | string | ```iampolicy-dev-ec2-sessionhost-appCICD``` | yes |


## Resources
| Name | Description |
|-----|-------------|
| aws_instance | Manages an AWS Transit Gateway. |
| aws_iam_role | Attaches a VPC to an AWS Transit Gateway. |
| aws_iam_policy | Manages a Transit Gateway Route Table. |
| aws_iam_role_policy_attachment | Manages a Transit Gateway Route. |
| aws_iam_instance_profile | Manages a Resource Share in AWS RAM. |


## Outputs
| Name | Description |
|-----|-------------|
| instance_id | The ID of the created EC2 instance. |
| public_ip | The public IP address associated with the instance (if applicable). |
| private_ip | The private IP address of the instance. |
| iam_role_arn | The ARN of the created IAM role. |
| iam_policy_arn | The ARN of the created IAM policy. |


This Terraform configuration is released under the MIT License.


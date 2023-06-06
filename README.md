Terraform AWS VPC Endpoint Module

This Terraform module creates VPC endpoints for various AWS services in a specified VPC.

Prerequisites

Before you can use this Terraform code, you'll need the following:

    An AWS account.
    AWS access keys with the necessary permissions
    Terraform is installed on your local machine.

### First, create a module file in the root directory and add the values of the following variables:

Kindly replace the values from the module given below.

    1. Create a module file in the root directory of your Terraform configuration.
    2. Add the necessary input variables to the module file, replacing the placeholder values with your desired configurations.
        

# Route 53 Module ########################################################################################################
```
module "vpc_endpoint" {
  source = "./module"

  end_points = {
    "cloudwatch" = {
      vpc_id              = "vpc-0a9e3d48ce8cac8eb"
      region_name         = "eu-central-1"
      subnet_ids          = ["subnet-02287b720ef893718", "subnet-0929dcccf33f6de99", "subnet-0c8da89bc328da685"]
      security_group_name = "monitoring-endpoint-sg"
      sg_cidr_blocks      = ["10.0.0.0/8"]
      from_port           = 443
      to_port             = 443
      service_name        = "com.amazonaws.eu-central-1.monitoring"
      private_dns_enabled = false
    },

    "cloudtrail" = {
      vpc_id              = "vpc-0a9e3d48ce8cac8eb"
      region_name         = "eu-central-1"
      subnet_ids          = ["subnet-02287b720ef893718", "subnet-0929dcccf33f6de99", "subnet-0c8da89bc328da685"]
      security_group_name = "cloudtrail-endpoint-sg"
      sg_cidr_blocks      = ["10.0.0.0/8"]
      from_port           = 443
      to_port             = 443
      service_name        = "com.amazonaws.eu-central-1.cloudtrail"
      private_dns_enabled = false
    },

    "identitystore" = {
      vpc_id              = "vpc-0a9e3d48ce8cac8eb"
      region_name         = "eu-central-1"
      subnet_ids          = ["subnet-02287b720ef893718", "subnet-0929dcccf33f6de99", "subnet-0c8da89bc328da685"]
      security_group_name = "identitystore-endpoint-sg"
      sg_cidr_blocks      = ["10.0.0.0/8"]
      from_port           = 443
      to_port             = 443
      service_name        = "com.amazonaws.eu-central-1.identitystore"
      private_dns_enabled = false
    },

    "ecr(dkr)" = {
      vpc_id              = "vpc-0a9e3d48ce8cac8eb"
      region_name         = "eu-central-1"
      subnet_ids          = ["subnet-02287b720ef893718", "subnet-0929dcccf33f6de99", "subnet-0c8da89bc328da685"]
      security_group_name = "ecr-dkr-endpoint-sg"
      sg_cidr_blocks      = ["10.0.0.0/8"]
      from_port           = 443
      to_port             = 443
      service_name        = "com.amazonaws.eu-central-1.ecr.dkr"
      private_dns_enabled = false
    },

    "ecr(api)" = {
      vpc_id              = "vpc-0a9e3d48ce8cac8eb"
      region_name         = "eu-central-1"
      subnet_ids          = ["subnet-02287b720ef893718", "subnet-0929dcccf33f6de99", "subnet-0c8da89bc328da685"]
      security_group_name = "ecr-api-endpoint-sg"
      sg_cidr_blocks      = ["10.0.0.0/8"]
      from_port           = 443
      to_port             = 443
      service_name        = "com.amazonaws.eu-central-1.ecr.api"
      private_dns_enabled = false
    },
  }
}
```

Getting Started

To get started, clone this repository to your local machine and navigate to the root directory. Then, run the following command to initialize the Terraform configuration:

```
terraform init
terraform plan
```

These values will be used to configure the VPC endpoints.

Finally, run the following command to apply the Terraform configuration:

```
terraform apply -auto-approve
```

This will create the VPC endpoints on your AWS account.

Outputs

After running the terraform apply command, you can use the following outputs to retrieve the IDs of the resources created:

    vpc_endpoint_id: This output provides the VPC endpoints ID of the module
    

Cleaning Up

To delete the resources created by this Terraform configuration, run the following command:

```
terraform destroy
```

This will delete the VPC endpoints from your AWS account.


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 4.0.0 |
| aws | >= 2.46 |


## Inputs
**Note:** All inputs with Yes under the **Required** column are mandatory to execute the Terraform module successfully.
| Name | Description | Type	| Default | Required |
|------|-------------|------|---------|----------|
| end_points | A map of endpoint configurations for different AWS services. Each key-value pair represents an endpoint configuration. | map(object) | ```(({}))``` | yes |
| vpc_id | The ID of the VPC in which to create the VPC endpoints. | string | ```""``` | yes |
| region_name | The AWS region where the VPC and endpoints are created. | string | ```""``` | yes |
| subnet_ids | The IDs of the subnets in the VPC for the VPC endpoints. | list | ```[]``` | yes |
| security_group_name | The AWS region where the DNS zone should be created. | string | ```""``` | yes |
| sg_cidr_blocks | A list of record prefixes for the DNS zone. Each prefix represents a subdomain within the domain name. | list |	```[]``` | yes |
| from_port | The AWS region where the VPC and endpoints are created. | number | ```""``` | yes |
| to_port | The IDs of the subnets in the VPC for the VPC endpoints. | number | ```""``` | yes |
| service_name | The AWS region where the DNS zone should be created. | string | ```""``` | yes |
| private_dns_enabled | A list of record prefixes for the DNS zone. Each prefix represents a subdomain within the domain name. | bool |	```false``` | yes |


## Resources
| Name | Description |
|-----|-------------|
| aws_security_group | Manages a security group, which acts as a virtual firewall to control inbound and outbound traffic for AWS resources. |
| aws_vpc_endpoint | Manages a VPC endpoint, which allows private access to AWS services from within a VPC. |


## Outputs
| Name | Description |
|-----|-------------|
| vpc_endpoint_id | The ID of the VPC endpoints. |


This Terraform configuration is released under the MIT License.


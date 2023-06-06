Terraform AWS Route53 Private Hosted Zone Module

This Terraform module sets up private hosted zones in Route53 for multiple VPCs in AWS.

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
provider "aws" {
  region = "eu-central-1"
}

module "route53_phz" {
  for_each              = var.dns_zones
  source                = "./module"   
  vpc_id                = each.value.vpc_id
  region_name           = each.value.region_name
  record_prefix         = each.value.record_prefix
  ep_type               = each.value.ep_type
  domain_name           = each.value.domain_name
  vpcs_for_associations_dt = each.value.vpcs_for_associations_dt
  vpcs_for_associations_nt = each.value.vpcs_for_associations_nt
  association_region    = each.value.association_region

  providers = {
    aws.network = aws.network
    aws.devtest = aws.devtest
  }
}
```

Getting Started

To get started, clone this repository to your local machine and navigate to the root directory. Then, run the following command to initialize the Terraform configuration:

```
terraform init
terraform plan
```

These values will be used to configure the Route 53 private hosted zone.

Finally, run the following command to apply the Terraform configuration:

```
terraform apply -auto-approve
```

This will create the Route 53 private hosted zone on your AWS account.

Outputs

After running the terraform apply command, you can use the following outputs to retrieve the IDs of the resources created:

    zone_id: This output provides the Zone ID of the Route 53 Private hosted DNS zone module
    

Cleaning Up

To delete the resources created by this Terraform configuration, run the following command:

```
terraform destroy
```

This will delete the Route 53 Private hosted zone from your AWS account.


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 4.0.0 |
| aws | >= 2.46 |


## Inputs
**Note:** All inputs with Yes under the **Required** column are mandatory to execute the Terraform module successfully.
| Name | Description | Type	| Default | Required |
|------|-------------|------|---------|----------|
| region | Specify the region. | string | ```""``` | yes |
| dns_zones | It is used to specify the configuration for multiple DNS zones in a declarative manner. | map(object) | ```(({}))``` | yes |
| vpc_id | The ID of the VPC associated with the DNS zone. | string | ```""``` | yes |
| region_name | The AWS region where the DNS zone should be created. | string | ```""``` | yes |
| record_prefix | A list of record prefixes for the DNS zone. Each prefix represents a subdomain within the domain name. | list(string) |	```()``` | yes |
| ep_type | A list of endpoint types for the DNS zone. It defines the type of endpoints associated with the subdomains. | list(string) |	```()``` | yes |
| domain_name | The domain name for the DNS zone. | string | ```""``` | yes |
| vpcs_for_associations_dt | A list of VPC IDs for DNS resolution associations of type "DNS resolvers" for the domain name. | list(string) |	```()``` | yes |
| vpcs_for_associations_nt | A list of VPC IDs for DNS resolution associations of type "DNS targets" for the domain name. | list(string) |	```()``` | yes |
| association_region | The AWS region where the DNS resolution associations should be created. | string | ```""``` | yes |


## Resources
| Name | Description |
|-----|-------------|
| aws_route53_zone | It represents a hosted zone within Route 53, which is a container for DNS records that define how traffic is routed for a specific domain. |
| aws_vpc_endpoint | It manages a VPC endpoint in AWS, allowing private access to AWS services from within a VPC. |
| aws_route53_record | It manages a DNS record in Amazon Route 53, allowing you to create, update, or delete DNS records for your domain. |


## Outputs
| Name | Description |
|-----|-------------|
| zone_id | The Zone ID of the Route 53 Private hosted DNS zone. |


This Terraform configuration is released under the MIT License.


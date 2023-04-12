#  ------------------- setting terraform Aws provider and defining version -------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = local.region
}

#  -------------------  defining local variable to be used locally -------------------

locals {
  region = "eu-central-1"

}

# -------------------  S3 backend configuration ---------------

terraform {
  backend "s3" {
    bucket = "justtooshow"
    key    = "ingress/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}


# VPC Module #################################################
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



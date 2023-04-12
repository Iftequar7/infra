
###########################   egress vpc variables values  ###################################

variable "region" {
  description = "Region for resources to be deployed"
  default     = "eu-central-1"
}


variable "vpc-cidr" {
  description = "Vpc-cidr range to be assigned"
  default     = "10.154.0.0/21"
}

variable "vpc-name" {
  description = "Vpc name to be assigned"
  default     = "egress-vpc"
}




variable "vpc_id" {

  default = "aws_vpc.main.id"
}

variable "subnet_cidr_block_pub" {
  type = list(any)
  default = [
    "10.154.0.0/25",
    "10.154.0.128/25",
    "10.154.1.0/25",

  ]
}
variable "availability_zone_pub" {
  type = list(any)
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c",

  ]
}

variable "subnet_name_map_pub" {
  type = map(string)
  default = {
    "10.154.0.0/25"   = "egress-access-public-subnet-a"
    "10.154.0.128/25" = "egress-access-public-subnet-b"
    "10.154.1.0/25"   = "egress-access-public-subnet-c"

  }
}

# egress private subnet ######################

variable "subnet_cidr_block_pvt" {
  type = list(any)
  default = [
    "10.154.1.128/25",
    "10.154.2.0/25",
    "10.154.2.128/25",

  ]
}
variable "availability_zone_pvt" {
  type = list(any)
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c",

  ]
}

variable "subnet_name_map_pvt" {
  type = map(string)
  default = {
    "10.154.1.128/25" = "egress-tgw-private-subnet-a"
    "10.154.2.0/25"   = "egress-tgw-private-subnet-b"
    "10.154.2.128/25" = "egress-tgw-private-subnet-c"

  }
}
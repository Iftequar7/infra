variable "region" {
  description = "Region for resources to be deployed"
  default     = ""
}


variable "vpc-cidr" {
  description = "Vpc-cidr range to be assigned"
  default     = ""
}

variable "vpc-name" {
  description = "Vpc name to be assigned"
  default     = ""
}

variable "vpc_id" {

  default = "aws_vpc.main.id"
}

variable "subnet_cidr_block_pub" {
  type = list(any)
  default = [ ]
}
variable "availability_zone_pub" {
  type = list(any)
  default = [ ]
}

variable "subnet_name_map_pub" {
  type = map(string)
  default = { }
}

# egress private subnet ######################

variable "subnet_cidr_block_pvt" {
  type = list(any)
  default = [ ]
}
variable "availability_zone_pvt" {
  type = list(any)
  default = [ ]
}

variable "subnet_name_map_pvt" {
  type = map(string)
  default = { }
}

variable "project_name" {
  type = string
  default = ""
}

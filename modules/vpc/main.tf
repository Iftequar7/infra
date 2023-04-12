# configuring Egress Vpc resource

resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = var.vpc-name
  }
}



## Configuring Public Subnet #####################

resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_pub[count.index]
  availability_zone = var.availability_zone_pub[count.index]

  tags = {
    Name = var.subnet_name_map_pub[var.subnet_cidr_block_pub[count.index]]
  }
}

## Configuring Internet gateway ########################

resource "aws_internet_gateway" "public" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "egress-igw"
  }
}

## Configuring Private Subnet #########################

resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_pvt[count.index]
  availability_zone = var.availability_zone_pvt[count.index]

  tags = {
    Name = var.subnet_name_map_pvt[var.subnet_cidr_block_pvt[count.index]]
  }
}

resource "aws_eip" "nat" {
  count = 3

  vpc = true

  tags = {
    Name = "egress-nat-ips-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = 3

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.private[count.index].id

  tags = {
    Name = "egress-natgw-${count.index + 1}"
  }
}


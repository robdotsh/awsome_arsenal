###############
# Data sources
###############

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_prefix_lists" "ssm_prefix_lists" {
  filter {
    name = "prefix-list-name"
    values = [
      "com.amazonaws.*.ssm",
      "com.amazonaws.*.ec2messages",
      "com.amazonaws.*.ssmmessages",
    ]
  }
}

###############
# Locals
###############

locals {
  # Limit AZs to requested count
  azs = slice(
    data.aws_availability_zones.available.names,
    0,
    var.availability_zone_count,
  )

  # Allow subnet mask to be tuned instead of hard-coded
  public_subnet_newbits  = 8
  private_subnet_newbits = 8

  public_cidr_blocks = [
    for i in range(var.availability_zone_count) :
    cidrsubnet(var.vpc_cidr_block, local.public_subnet_newbits, i)
  ]

  private_cidr_blocks = [
    for i in range(var.availability_zone_count) :
    cidrsubnet(var.vpc_cidr_block, local.private_subnet_newbits, i + var.availability_zone_count)
  ]

  nat_gateway_count = var.nat_gateway_strategy == "one_per_az" ? var.availability_zone_count : 1
}

###############
# VPC and Internet Gateway
###############

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "multi-tier-vpc-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "multi-tier-igw-${var.environment}"
    Environment = var.environment
  }
}

###############
# Subnets
###############

resource "aws_subnet" "public" {
  count = var.availability_zone_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_cidr_blocks[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet-${local.azs[count.index]}-${var.environment}"
    Tier        = "public"
    Network     = "Public"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count = var.availability_zone_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_cidr_blocks[count.index]
  availability_zone = local.azs[count.index]

  tags = {
    Name        = "private-subnet-${local.azs[count.index]}-${var.environment}"
    Tier        = "private"
    Network     = "Private"
    Environment = var.environment
  }
}

###############
# Public route table and association
###############

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "public-rt-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  count = var.availability_zone_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

###############
# NAT EIPs and NAT Gateways
###############

resource "aws_eip" "nat" {
  count = local.nat_gateway_count

  domain = "vpc"

  tags = {
    Name        = "nat-eip-${count.index}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "nat" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id

  # If single NAT, always attach to the first public subnet.
  # If one_per_az, attach one NAT per AZ.
  subnet_id = (var.nat_gateway_strategy == "single"
    ? aws_subnet.public[0].id
  : aws_subnet.public[count.index].id)

  tags = {
    Name        = "nat-gw-${local.azs[count.index % var.availability_zone_count]}-${var.environment}"
    Environment = var.environment
  }
}

###############
# Private route tables and associations
###############

resource "aws_route_table" "private" {
  count = var.availability_zone_count

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = (var.nat_gateway_strategy == "single"
      ? aws_nat_gateway.nat[0].id
      : aws_nat_gateway.nat[count.index].id
    )
  }

  tags = {
    Name        = "private-rt-${local.azs[count.index]}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private" {
  count = var.availability_zone_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

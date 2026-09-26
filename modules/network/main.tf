# ------------------------
# VPC
# ------------------------

resource "aws_vpc" "vpc" {
  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
    Env  = var.environment
  }
}

# ------------------------
# Public / Private Subnet
# ------------------------

# Public Cidr (10.0.0.0/24、10.0.1.0/24)
resource "aws_subnet" "public_subnet" {
  for_each = toset(var.public_subnet_azs)

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, index(var.public_subnet_azs, each.value))
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.project_name}-${var.environment}-public-${substr(each.value, -2, 2)}"
    Env  = var.environment
  }
}

# Private Cidr (10.0.10.0/24、10.0.11.0/24)
resource "aws_subnet" "private_subnet" {
  for_each = toset(var.private_subnet_azs)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, index(var.private_subnet_azs, each.value) + 10)

  tags = {
    Name = "${var.project_name}-${var.environment}-private-${substr(each.value, -2, 2)}"
    Env  = var.environment
  }
}
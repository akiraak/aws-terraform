resource "aws_subnet" "public_management_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_public_management_1_cidr_block
  availability_zone = local.az_1
  tags = {
    Name = "${local.service_prefix}-public-management-1"
  }
}

resource "aws_subnet" "public_management_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_public_management_2_cidr_block
  availability_zone = local.az_2
  tags = {
    Name = "${local.service_prefix}-public-management-2"
  }
}

resource "aws_subnet" "public_app_alb_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_public_app_alb_1_cidr_block
  availability_zone = local.az_1
  tags = {
    Name = "${local.service_prefix}-public-app-alb-1"
  }
}

resource "aws_subnet" "public_app_alb_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_public_app_alb_2_cidr_block
  availability_zone = local.az_2
  tags = {
    Name = "${local.service_prefix}-public-app-alb-2"
  }
}

resource "aws_subnet" "private_app_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_private_app_1_cidr_block
  availability_zone = local.az_1
  tags = {
    Name = "${local.service_prefix}-private-app-1"
  }
}

resource "aws_subnet" "private_app_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_private_app_2_cidr_block
  availability_zone = local.az_2
  tags = {
    Name = "${local.service_prefix}-private-app-2"
  }
}

resource "aws_route_table_association" "private_app_1" {
  subnet_id      = aws_subnet.private_app_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_app_2" {
  subnet_id      = aws_subnet.private_app_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_subnet" "private_app_db_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_private_app_db_1_cidr_block
  availability_zone = local.az_1
  tags = {
    Name = "${local.service_prefix}-private-app-db-1"
  }
}

resource "aws_subnet" "private_app_db_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc.subnet_private_app_db_2_cidr_block
  availability_zone = local.az_2
  tags = {
    Name = "${local.service_prefix}-private-app-db-2"
  }
}

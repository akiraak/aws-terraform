resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${local.service_prefix}-public"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_management_1" {
  subnet_id      = aws_subnet.public_management_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_management_2" {
  subnet_id      = aws_subnet.public_management_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_app_alb_1" {
  subnet_id      = aws_subnet.public_app_alb_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_app_alb_2" {
  subnet_id      = aws_subnet.public_app_alb_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    nat_gateway_id = aws_nat_gateway.main.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "${local.service_prefix}-private"
  }
}

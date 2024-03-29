resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_app_alb_1.id

  tags = {
    Name = "${local.service_prefix}"
  }
}

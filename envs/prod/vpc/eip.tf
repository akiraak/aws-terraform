resource "aws_eip" "nat_gateway" {
  vpc = true
  tags = {
    Name = "${local.service_prefix}-nat-gateway"
  }
}

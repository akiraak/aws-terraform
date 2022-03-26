resource "aws_vpc" "main" {
  cidr_block           = var.vpc.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main"
  }
}

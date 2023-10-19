resource "aws_vpc" "vpc-default" {
  count                            = var.mycount
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = lookup(var.aws_cidr, element(var.aws_vpc, count.index))
  enable_dns_hostnames             = false
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    "Name" = element(var.aws_vpc, count.index)
  }
}

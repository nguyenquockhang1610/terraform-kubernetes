resource "aws_vpc" "cluster" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = "10.0.0.0/22"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    "Name" = format("eks-%s-cluster", aws_ssm_parameter.tf-eks-cluster-name.value)
  }
}

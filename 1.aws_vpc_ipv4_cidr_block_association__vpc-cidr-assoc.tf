resource "aws_vpc_ipv4_cidr_block_association" "vpc-cidr-assoc" {
  cidr_block = "100.64.0.0/16"
  vpc_id     = aws_vpc.cluster.id
}
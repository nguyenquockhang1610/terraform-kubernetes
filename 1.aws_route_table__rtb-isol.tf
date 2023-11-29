resource "aws_route_table" "rtb-i" {
  propagating_vgws = []
  route            = []
  tags = {
    "Name" = format("eks-%s-cluster/IsolatedRouteTable", aws_ssm_parameter.tf-eks-cluster-name.value)
  }
  vpc_id = aws_vpc.cluster.id
}
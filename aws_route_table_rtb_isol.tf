resource "aws_route_table" "routeTable-i1" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name = format("eks-%s-cluster/IsolatedRouteTable", aws_ssm_parameter.tf-eks-cluster-name.value)
  }
}

resource "aws_route_table" "routeTable-i2" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name = format("eks-%s-cluster/IsolatedRouteTable", aws_ssm_parameter.tf-eks-cluster-name.value)
  }
}

resource "aws_route_table" "routeTable-i3" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name = format("eks-%s-cluster/IsolatedRouteTable", aws_ssm_parameter.tf-eks-cluster-name.value)
  }
}
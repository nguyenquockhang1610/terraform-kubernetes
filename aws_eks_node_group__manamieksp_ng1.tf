resource "aws_eks_node_group" "ng1" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = format("ng1-%s", aws_eks_cluster.cluster.name)
  node_role_arn   = aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole-1GFKA1037E1XO.arn
  subnet_ids = [
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
    aws_subnet.subnet-i3.id,
  ]

  launch_template {
    id      = aws_launch_template.lt-ng1.id
    version = aws_launch_template.lt-ng1.latest_version
  }

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}

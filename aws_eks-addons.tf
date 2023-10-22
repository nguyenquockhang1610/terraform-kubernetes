locals {
  cni_config = file("${path.module}/cni.json")
}


resource "aws_eks_addon" "vpc-cni" {
  depends_on        = [aws_eks_cluster.cluster]
  cluster_name      = aws_ssm_parameter.tf-eks-cluster-name.value
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"

  configuration_values = local.cni_config
  addon_version        = "v1.14.1-eksbuild.1"

  preserve = true

}

resource "aws_eks_addon" "kube-proxy" {
  depends_on     = [aws_eks_node_group.ng1]
  cluster_name  = aws_ssm_parameter.tf-eks-cluster-name.value
  addon_name    = "kube-proxy"
  addon_version = "v1.28.1-eksbuild.1"
}

resource "aws_eks_addon" "coredns" {
  depends_on           = [aws_eks_node_group.ng1]
  cluster_name         = aws_ssm_parameter.tf-eks-cluster-name.value
  addon_name           = "coredns"
  configuration_values = "{\"replicaCount\":2,\"resources\":{\"limits\":{\"cpu\":\"100m\",\"memory\":\"150Mi\"},\"requests\":{\"cpu\":\"100m\",\"memory\":\"150Mi\"}}}"
  addon_version        = "v1.10.0-eksbuild.4"
}
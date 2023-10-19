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
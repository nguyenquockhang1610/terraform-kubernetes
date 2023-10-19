resource "aws_ssm_parameter" "eksami" {
  name        = format("/eks/eks-cluster/ami-id")
  description = "EKS AMI Image ID"
  type        = "String"
  value       = "ami-0f844a9675b22ea32"
}

resource "aws_eks_cluster" "cluster" {
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
  name = aws_ssm_parameter.tf-eks-cluster-name.value

  role_arn = aws_iam_role.eks-cluster-ServiceRole-HUIGIC7K7HNJ.arn
  tags     = {}
  version  = var.eks_version

  timeouts {}

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
    public_access_cidrs = [
      "0.0.0.0/0",
    ]
    security_group_ids = [
      aws_security_group.cluster-sg.id,
    ]
    subnet_ids = [
      aws_subnet.subnet-p1.id,
      aws_subnet.subnet-p2.id,
      aws_subnet.subnet-p3.id,
    ]
  }
  encryption_config {
    provider {
      key_arn = aws_kms_key.ekskey.arn
    }
    resources = ["secrets"]
  }

}

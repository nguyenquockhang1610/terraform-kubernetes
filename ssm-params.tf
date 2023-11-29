resource "aws_ssm_parameter" "tf-eks-id" {
  name        = "/eks/tf-eks/id"
  description = "The unique id"
  type        = "String"
  value       = random_id.id1.hex
  overwrite   = true

  tags = {
    name = "tf-eks"
  }
}

resource "aws_ssm_parameter" "tf-eks-keyid" {
  name        = "/eks/tf-eks/keyid"
  description = "The keyid"
  type        = "String"
  value       = aws_kms_key.ekskey.key_id
  overwrite   = true

  tags = {
    name = "tf-eks"
  }
}

resource "aws_ssm_parameter" "tf-eks-keyarn" {
  name        = "/eks/tf-eks/keyarn"
  description = "The keyid"
  type        = "String"
  value       = aws_kms_key.ekskey.arn
  overwrite   = true

  tags = {
    name = "tf-eks"
  }
}

resource "aws_ssm_parameter" "tf-eks-region" {
  name        = "/eks/tf-eks/region"
  description = "The region"
  type        = "String"
  value       = var.region
  overwrite   = true

  tags = {
    name = "tf-eks"
  }
}

resource "aws_ssm_parameter" "tf-eks-cluster-name" {
  name        = "/eks/tf-eks/cluster-name"
  description = "The EKS cluster name"
  type        = "String"
  value       = var.cluster-name
  overwrite   = true

  tags = {
    name = "tf-eks"
  }
}

resource "aws_ssm_parameter" "cluster_service_role_arn" {
  name      = "/eks/cluster_service_role_arn"
  type      = "String"
  value     = "aws_iam_role.eks-cluster-ServiceRole.arn"
  overwrite = true
}

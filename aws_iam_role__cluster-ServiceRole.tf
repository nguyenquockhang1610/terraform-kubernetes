resource "aws_iam_role" "eks-cluster-ServiceRole" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = [
              "eks-fargate-pods.amazonaws.com",
              "eks.amazonaws.com",
            ]
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "eks-cluster-ServiceRole"
  path                  = "/"
  tags = {
    "Name" = "eks-cluster/ServiceRole"

  }
}


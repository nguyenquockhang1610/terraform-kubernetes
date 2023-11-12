resource "aws_iam_role_policy" "eks-cluster-ServiceRole__eks-cluster-PolicyELBPermissions" {
  name = format("%s-eks-cluster-PolicyELBPermissions", aws_ssm_parameter.tf-eks-id.value)
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "ec2:DescribeAccountAttributes",
            "ec2:DescribeAddresses",
            "ec2:DescribeInternetGateways",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
  role = aws_iam_role.eks-cluster-ServiceRole.id
}
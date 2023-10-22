resource "aws_iam_role_policy" "eks-nodegroup-ng-ma-NodeInstanceRole__eks-nodegroup-ng-maneksami2-PolicyAutoScaling" {
  name = "eks-nodegroup-ng-maneksami2-PolicyAutoScaling"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "autoscaling:DescribeAutoScalingGroups",
            "autoscaling:DescribeAutoScalingInstances",
            "autoscaling:DescribeLaunchConfigurations",
            "autoscaling:DescribeTags",
            "autoscaling:SetDesiredCapacity",
            "autoscaling:TerminateInstanceInAutoScalingGroup",
            "ec2:DescribeLaunchTemplateVersions",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
      Version = "2012-10-17"
    }
  )
  role = aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole.id
}
resource "aws_iam_policy_attachment" "eks-nodegroup-eks-policy-attachments" {
  name       = "eks-nodegroup-eks-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  roles      = [aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole.name]
}

resource "aws_iam_policy_attachment" "eks-nodegroup-ecr-policy-attachments" {
  name       = "eks-nodegroup-ecr-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  roles      = [aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole.name]
}

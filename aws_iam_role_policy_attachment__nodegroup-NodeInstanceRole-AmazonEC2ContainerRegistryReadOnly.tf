resource "aws_iam_role_policy_attachment" "eks-nodegroup-ng-ma-NodeInstanceRole__AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole.id
}

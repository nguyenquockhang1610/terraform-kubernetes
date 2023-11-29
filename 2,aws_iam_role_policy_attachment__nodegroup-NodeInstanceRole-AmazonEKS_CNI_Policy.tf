resource "aws_iam_role_policy_attachment" "eks-nodegroup-ng-ma-NodeInstanceRole__AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole.id
}
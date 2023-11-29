resource "aws_iam_role_policy_attachment" "eks-cluster-ServiceRole__AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-cluster-ServiceRole.id
}
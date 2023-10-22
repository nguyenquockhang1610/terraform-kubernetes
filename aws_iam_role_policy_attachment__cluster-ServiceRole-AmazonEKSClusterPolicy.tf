resource "aws_iam_role_policy_attachment" "eks-cluster-ServiceRole__AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-ServiceRole.id
}

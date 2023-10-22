resource "aws_iam_role_policy_attachment" "eks-nodegroup-ng-ma-NodeInstanceRole__AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole.id
}
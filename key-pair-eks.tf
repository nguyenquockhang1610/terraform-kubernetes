resource "aws_key_pair" "eks_key" {
  key_name   = "eks"
  public_key = tls_private_key.eks_key.public_key_openssh
}

resource "tls_private_key" "eks_key" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  content  = tls_private_key.eks_key.private_key_pem
  filename = "/home/ubuntu/terraform/eks.pem"
}

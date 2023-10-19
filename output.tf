output "region" {
  value = "us-east-1" # Thay thế giá trị này bằng giá trị thực tế của bạn
}

output "s3_bucket" {
  value = "remotebackend-01" # Thay thế giá trị này bằng giá trị thực tế của bạn
}

output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "ca" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

# Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019.
output "identity-oidc-issuer" {
  value = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

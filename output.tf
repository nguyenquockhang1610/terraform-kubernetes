output "region" {
  value = "ap-southeast-1p" # Thay thế giá trị này bằng giá trị thực tế của bạn
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

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: aws_iam_role.eks-nodegroup-ng-ma-NodeInstanceRole.arn
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: aws_eks_cluster.cluster.endpoint
    certificate-authority-data: aws_eks_cluster.cluster.certificate_authority.0.data
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "aws_eks_cluster.cluster.name"
KUBECONFIG
}

output "config-map-aws-auth" {
  value = "local.config-map-aws-auth"
}

output "kubeconfig" {
  value = "local.kubeconfig"
}

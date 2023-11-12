resource "null_resource" "policy" {
  depends_on = [aws_eks_node_group.ng1]
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    on_failure  = fail
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
            curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.1/docs/install/iam_policy.json
     EOT
  }
}
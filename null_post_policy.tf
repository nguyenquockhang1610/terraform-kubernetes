resource "null_resource" "post-policy" {
  depends_on = [aws_iam_policy.load-balancer-policy]
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    on_failure  = fail
    interpreter = ["/bin/bash", "-c"]
    when        = create
    command     = <<EOT
        reg=$(echo ${aws_eks_cluster.cluster.arn} | cut -f4 -d':')
        acc=$(echo ${aws_eks_cluster.cluster.arn} | cut -f5 -d':')
        cn=$(echo ${aws_eks_cluster.cluster.name})
        echo "$reg $cn $acc"
        ./post-policy.sh $reg $cn $acc
        #echo "reannotate nodes"
        #cd ../eks-cidr
        #./reannotate-nodes.sh $cn
        echo "done"
     EOT
  }
}
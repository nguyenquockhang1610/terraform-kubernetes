resource "null_resource" "gen_cluster_auth" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_eks_cluster.cluster]
  provisioner "local-exec" {
    on_failure  = fail
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "\x1B[31m Warning! Testing Network Connectivity ${aws_eks_cluster.cluster.name}...should see port 443/tcp open  https\x1B[0m"
        /home/ubuntu/terraform/3.test.sh
        echo -e "\x1B[31m Warning! Checking Authorization ${aws_eks_cluster.cluster.name}...should see Server Version: v1.17.xxx \x1B[0m"
        /home/ubuntu/terraform/3.auth.sh
        echo "************************************************************************************"
     EOT
  }
}


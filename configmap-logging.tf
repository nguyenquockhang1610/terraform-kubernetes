resource "kubernetes_namespace" "aws-observability" {
  depends_on = [null_resource.update_kubeconfig]
  metadata {
    annotations = {}
    labels = {
      "aws-observability" = "enabled"
    }
    name = "aws-observability"
  }

  timeouts {}
}

resource "kubernetes_config_map" "aws-observability__aws-logging" {
  binary_data = {}
  data = {
    "output.conf" = <<-EOT
            [OUTPUT]
                Name cloudwatch
                Match *
                region ${var.region}
                log_group_name fluent-bit-eks-fargate
                log_stream_prefix fargate1-
                auto_create_group true
                sts_endpoint https://sts.${var.region}.amazonaws.com
                endpoint https://logs.${var.region}.amazonaws.com  
        EOT
  }

  metadata {
    name      = "aws-logging"
    namespace = kubernetes_namespace.aws-observability.id
  }
}
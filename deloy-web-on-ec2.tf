resource "null_resource" "update_kubeconfig" {
  depends_on = [aws_eks_cluster.cluster]

  provisioner "local-exec" {
    command = <<EOT
      aws eks update-kubeconfig --name mycluster1 &&
      cat ${pathexpand("~/.kube/config")} > /home/ubuntu/.kube/tmp_config &&
      mv /home/ubuntu/.kube/tmp_config /home/ubuntu/.kube/config
    EOT
  }
}



// define namespace 
resource "kubernetes_namespace" "my-web-app" {
  depends_on = [null_resource.update_kubeconfig]
  metadata {
    name = "my-web-app"
  }

  timeouts {
    delete = "20m"
  }
}

resource "kubernetes_deployment" "my_web_app__deployment" {
  depends_on = [kubernetes_namespace.my-web-app]
  metadata {
    name      = "deployment-my-web-app"
    namespace = "my-web-app"
  }

  spec {
    replicas = 4
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "my-web-app"
      }
    }
    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = "50%"
        max_unavailable = "50%"
      }
    }

    template {
      metadata {
        annotations = {}
        labels      = { "app.kubernetes.io/name" = "my-web-app" }
      }

      spec {

        node_selector                    = { "alpha.eksctl.io/nodegroup-name" = "ng1-mycluster1" }
        restart_policy                   = "Always"
        share_process_namespace          = false
        termination_grace_period_seconds = 30

        container {
          image             = "935072788834.dkr.ecr.us-east-1.amazonaws.com/my-web-app"
          name              = "my-web-app"
          image_pull_policy = "Always"
          port {
            container_port = 80
            protocol       = "TCP"
          }

          resources {
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "my-web-app__service" {
  depends_on = [kubernetes_deployment.my_web_app__deployment]
  metadata {
    name      = "service-my-web-app"
    namespace = "my-web-app"
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "my-web-app"
    }

    type = "NodePort"

    port {
      port        = 80
      protocol    = "TCP"
      target_port = "80"
    }
  }

}

resource "kubernetes_ingress_v1" "my-web-app__ingress" {
  depends_on = [kubernetes_service.my-web-app__service]
  metadata {
    annotations = { "alb.ingress.kubernetes.io/scheme" = "internal", "alb.ingress.kubernetes.io/target-type" = "ip", "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\": 8080}]" }
    name        = "ingress-my-web-app"
    namespace   = "my-web-app"
  }
  spec {
    ingress_class_name = "alb"
    rule {
      http {
        path {
          path = "/"
          backend {
            service {
              name = "service-my-web-app"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
resource "null_resource" "update_kubeconfig" {
  depends_on = [aws_eks_cluster.cluster]

  provisioner "local-exec" {
    command = <<EOT
      aws eks update-kubeconfig --name ${aws_eks_cluster.mycluster1.name} --kubeconfig /home/ubuntu/terraform/.kube/config
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
  depends_on = [kubernetes_namespace.my-web-app, aws_eks_node_group.ng1]
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
          image             = "871694379403.dkr.ecr.ap-southeast-1.amazonaws.com/my-web-app:latest"
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
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-external" = "true"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "my-web-app"
    }

    type = "LoadBalancer"

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
    annotations = {
      "alb.ingress.kubernetes.io/scheme"       = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"  = "ip"
      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\": 80}]"
    }
    name      = "ingress-my-web-app"
    namespace = "my-web-app"
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
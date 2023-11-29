resource "kubernetes_role" "my-web-app__role" {
  metadata {
    name      = "my-web-app-role"
    namespace = "my-web-app"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding" "my-web-app__role_binding" {
  metadata {
    name      = "my-web-app-role-binding"
    namespace = "my-web-app"
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.my-web-app__role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "my-web-app"
  }
}

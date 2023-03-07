resource "helm_release" "kube-prometheus-stack" {
  name       = "prom-demo"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "45.6.0"

  values = [
    "${file("./helm-values/kube-prometheus-stack.yaml")}"
  ]
}

resource "helm_release" "vault" {
  name       = "vault-demo"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.23.0"
}


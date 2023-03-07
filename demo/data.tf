data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name  = "foo"
}

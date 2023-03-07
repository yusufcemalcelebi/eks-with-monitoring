locals {
  cluster_name = "tf-${basename(abspath(path.module))}"
  env_name     = basename(abspath(path.module))
}

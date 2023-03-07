module "aws-lb-controller" {
  source = "../modules/aws-lb-controller"

  region              = data.aws_region.current.name
  account_id          = data.aws_caller_identity.current.account_id
  cluster_name        = local.cluster_name
  openid_provider_url = module.eks.oidc_provider
}

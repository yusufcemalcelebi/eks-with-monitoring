output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_platform_version" {
  value = module.eks.cluster_platform_version
}

output "cluster_status" {
  value = module.eks.cluster_status
}

output "aws_auth_configmap_yaml" {
  value = module.eks.aws_auth_configmap_yaml
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  value = module.eks.oidc_provider
}

output "cluster_identity_providers" {
  value = module.eks.cluster_identity_providers
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

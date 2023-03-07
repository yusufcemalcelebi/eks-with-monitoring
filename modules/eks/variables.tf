variable "cluster_name" {
  description = "Name of EKS cluster"
}

variable "cluster_version" {
  description = "EKS Cluster version ex: 1.21"
}

variable "vpc_id" {
  description = "VPC id that will host EKS cluster"
}

variable "private_subnets" {
  description = "Private subnet ids"
}

variable "cluster_additional_security_group_ids" {
  description = "List of additional, externally created security group IDs to attach to the cluster control plane"
  type        = list(string)
  default     = []
}
variable "aws_auth_roles" {
  description = "AWS IAM roles to authenticate with EKS cluster"
  type        = list(any)
  default     = []
}

variable "aws_auth_users" {
  description = "AWS IAM users to authenticate with EKS cluster"
  type        = list(any)
  default     = []
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDRs to allow access to the cluster endpoint"
  type        = list(string)
  default     = []
}

variable "environment" {
  type = string
}

variable "eks_managed_node_groups" {
  type = any
}

module "eks" {
  source = "../modules/eks"

  cluster_name    = local.cluster_name
  environment     = local.env_name
  cluster_version = "1.25"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/terraform"
      username = "terraform"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/yusuf"
      username = "yusuf"
      groups   = ["system:masters"]
    }
  ]

  cluster_endpoint_public_access_cidrs = [
    "188.119.40.142/32",
    "46.196.92.56/32"
  ]

  eks_managed_node_groups = {
    bottlerocket_default = {
      subnet_ids   = module.vpc.private_subnets
      min_size     = 3
      max_size     = 5
      desired_size = 3

      instance_types = ["m6i.large", "m6a.large", "m5.large", "m5a.large", "m5n.large", "m5zn.large"] # Various instance types to increase availability
      capacity_type  = "SPOT"

      iam_role_additional_policies = {
        AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }
      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 80
            volume_type           = "gp3"
            delete_on_termination = true
          }
        }
        xvdb = {
          device_name = "/dev/xvdb"
          ebs = {
            volume_size           = 80
            volume_type           = "gp3"
            delete_on_termination = true
          }
        }
      }
    }
  }
}

resource "aws_ebs_encryption_by_default" "default" {
  enabled = true
}

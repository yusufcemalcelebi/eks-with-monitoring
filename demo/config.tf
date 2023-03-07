provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Environment = "Demo"
      Owner       = "Yusuf"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200/"
}

##################### Comment in this part after the initilization ################################
data "aws_eks_cluster" "default" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "default" {
  name = local.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}
###################################################################################################

##################### Comment out this part after the initilization ###############################
# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
#     command     = "aws"
#   }
# }


# provider "helm" {
#   kubernetes {
#     host                   = module.eks.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", local.cluster_name]
#       command     = "aws"
#     }
#   }
# }
###################################################################################################

terraform {
  backend "s3" {
    bucket         = "yusuf-eks-with-monitoring"
    key            = "demo/terraform.tfstate"
    dynamodb_table = "eks-with-monitoring-tf-state-lock"
    region         = "eu-west-1"
  }
}

resource "aws_iam_policy" "aws_lb_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "AWS LoadBalancer controller policy for the EKS"
  policy      = file("${path.module}/iam-policy.json")
}

data "aws_iam_policy_document" "aws_lb_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.account_id}:oidc-provider/${var.openid_provider_url}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.openid_provider_url}:sub"

      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.openid_provider_url}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "eks_aws_lb_controller_role" {
  name                = "eks_tf_management_aws_lb_controller_role"
  assume_role_policy  = data.aws_iam_policy_document.aws_lb_controller_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.aws_lb_controller_policy.arn]
}

resource "kubernetes_service_account" "aws_load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_aws_lb_controller_role.arn
    }
  }

  automount_service_account_token = true
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  chart      = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"

  namespace = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = false
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
}

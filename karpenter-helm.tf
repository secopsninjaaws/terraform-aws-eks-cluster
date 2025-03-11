provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.main.id, "--region", var.region]
    }
  }
}

resource "helm_release" "karpenter" {
    name       = "karpenter"
    repository = "https://charts.karpenter.sh/"
    chart      = "karpenter"
    version    = var.chart_version
    namespace  = var.karpenter_namespace
    create_namespace = true
    depends_on = [
        aws_eks_cluster.main,
        aws_eks_node_group.main,
        aws_iam_role.karpenter_controller,
        aws_iam_role_policy_attachment.karpenter_controller_policy_attachment,
        aws_iam_policy.karpenter_controller,
        aws_iam_policy_attachment.karpenter_controller_policy_attachment,
        aws_iam_instance_profile.karpenter
    ]
    set {
        name  = "serviceAccount.annotations.eks.amazonaws.com/role-arn"
        value = aws_iam_role.karpenter_controller.arn
    }

    set {
        name  = "clusterName"
        value = aws_eks_cluster.main.id
    }

    set {
        name  = "clusterEndpoint"
        value = aws_eks_cluster.main.endpoint
    }

    set {
      name = "aws.defaultInstanceProfile"
      value = aws_iam_instance_profile.karpenter.name
    }
}


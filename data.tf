data "tls_certificate" "eks_oidc_tls_certificate" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.main.id
}
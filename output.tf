output "oidc" {
  value = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint

}
output "eks_cluster_name" {
  value = aws_eks_cluster.main.id
}
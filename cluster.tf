resource "aws_eks_cluster" "main" {
  name     = format("%s-eks-cluster", var.project_name)
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids              = var.private_subnets
    endpoint_private_access = true                ### habilitando para comunicação ficar dentro da VPC
    endpoint_public_access  = var.public_endpoint ### habilitando para comunicação ficar fora da VPC por padrão está falso
  }

  depends_on = [aws_iam_role.eks_role, aws_iam_role_policy_attachment.eks_policy_attachment]

  tags = {
    Name = format("%s-eks-cluster", var.project_name)
  }
}
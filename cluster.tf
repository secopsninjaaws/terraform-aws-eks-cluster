resource "aws_eks_cluster" "main" {
  name     = format("%s-eks-cluster", var.project_name)
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = [
      var.private_subnet_1a,
      var.private_subnet_1b,
      var.private_subnet_1c
    ]
    endpoint_private_access = true ### habilitando para comunicação ficar dentro da VPC
    endpoint_public_access  = true
  }


  depends_on = [aws_iam_role.eks_role, aws_iam_role_policy_attachment.eks_policy_attachment]

  tags = {
    Name = format("%s-eks-cluster", var.project_name)
  }
}
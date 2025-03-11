resource "aws_eks_node_group" "main" {
  cluster_name    = var.cluster_name
  node_group_name = format("%s-node-group", var.project_name)
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = [var.private_aws_subnet_1a_id, var.private_aws_subnet_1b_id, var.private_aws_subnet_1c_id]
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  tags = {
    Name = format("%s-node-group", var.project_name)
  }
  depends_on = [
    aws_iam_role.eks_node_group_role,
    aws_iam_role_policy_attachment.eks_node_group_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_ec2_policy_attachment,

  ]
}
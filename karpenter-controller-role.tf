data "aws_iam_policy_document" "karpenter_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.karpenter_namespace}:karpenter"]
    }
  }

}

resource "aws_iam_role" "karpenter_controller" {
  name               = format("%s-karpenter-controller-role", var.project_name)
  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume_role_policy.json
  tags = {
    Name = format("%s-karpenter-controller-role", var.project_name)
  }
}

resource "aws_iam_role_policy_attachment" "karpenter_controller_policy_attachment" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = aws_iam_policy.karpenter_controller.arn
}

resource "aws_iam_policy" "karpenter_controller" {
  name        = format("%s-karpenter-controller-policy", var.project_name)
  description = "Policy for Karpenter controller"
  policy      = file("${path.module}/controller-trust-policy.json")
}

resource "aws_iam_policy_attachment" "karpenter_controller_policy_attachment" {
  name       = format("%s-karpenter-controller-policy-attachment", var.project_name)
  roles      = [aws_iam_role.karpenter_controller.name]
  policy_arn = aws_iam_policy.karpenter_controller.arn
}

resource "aws_iam_instance_profile" "karpenter" {
  name = format("%s-karpenter-instance-profile", var.project_name)
  role = aws_iam_role.karpenter_controller.name
  tags = {
    Name = format("%s-karpenter-instance-profile", var.project_name)
  }
}
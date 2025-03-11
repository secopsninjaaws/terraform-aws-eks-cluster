variable "eks_role_name" {
  description = "The name of the EKS role"
  type        = string
  default     = "eks-role"

}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "Lucas-EKS-Module"

}
variable "private_aws_subnet_1a_id" {
  description = "The private subnet in the first availability zone"
  type        = string

}

variable "private_aws_subnet_1b_id" {
  description = "The private subnet in the second availability zone"
  type        = string

}

variable "private_aws_subnet_1c_id" {
  description = "The private subnet in the third availability zone"
  type        = string

}

variable "desired_size" {
  description = "The desired number of worker nodes"
  type        = number
  default     = 1

}

variable "max_size" {
  description = "The maximum number of worker nodes"
  type        = number
  default     = 2

}

variable "min_size" {
  description = "The minimum number of worker nodes"
  type        = number
  default     = 0

}

variable "instance_types" {
  description = "The instance types for the worker nodes"
  type        = list(string)
  default     = ["t3.medium"]

}

variable "capacity_type" {
  description = "The capacity type for the worker nodes"
  type        = string
  default     = "SPOT"

}

variable "disk_size" {
  description = "The disk size for the worker nodes"
  type        = number
  default     = 50

}

variable "karpenter_namespace" {
  description = "The namespace for Karpenter"
  type        = string
  default     = "karpenter"
}

variable "chart_version" {
  description = "The version of the Karpenter chart"
  type        = string
  default     = "0.16.3"
  
}
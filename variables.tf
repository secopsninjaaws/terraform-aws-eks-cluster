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
variable "private_subnets" {
  description = "The private subnet in the first availability zone"
  type        = list(string)
}

variable "desired_size" {
  description = "The desired number of worker nodes"
  type        = number
  default     = 2

}

variable "max_size" {
  description = "The maximum number of worker nodes"
  type        = number
  default     = 3

}

variable "min_size" {
  description = "The minimum number of worker nodes"
  type        = number
  default     = 2

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

variable "region" {
  description = "The region for the EKS cluster"
  type        = string
  default     = "us-east-1"

}

variable "public_endpoint" {
  description = "Enable public endpoint for the EKS cluster"
  type        = bool
  default     = false
}
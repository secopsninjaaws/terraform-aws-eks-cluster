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
variable "private_subnet_1a" {
  description = "The private subnet in the first availability zone"
  type        = string

}

variable "private_subnet_1b" {
  description = "The private subnet in the second availability zone"
  type        = string

}

variable "private_subnet_1c" {
  description = "The private subnet in the third availability zone"
  type        = string

}

# Security Group Variables

variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the SG will be created"
  type        = string
}

variable "bastion_cidr" {
  type        = list(string)
  description = "CIDR block allowed for SSH (e.g., Bastion IP)"
}


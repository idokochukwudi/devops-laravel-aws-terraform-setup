variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "key_pair_name" {
  default = "laravel-key"
}

variable "public_key_path" {
  default = "~/.ssh/laravel-key.pub"
}

# NETWORK
variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "project" {
  description = "The name of the project used for tagging and naming resources."
  type        = string
}

# SECURITY GROUP
variable "bastion_cidr" {
  type        = list(string)
  description = "CIDR blocks allowed to SSH into the bastion host"
}


# EC2
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# Bastion Host Variables
variable "create_bastion" {
  description = "Flag to enable or disable Bastion host creation"
  type        = bool
}

variable "bastion_ami_id" {
  description = "AMI ID to use for the Bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the Bastion host"
  type        = string
}

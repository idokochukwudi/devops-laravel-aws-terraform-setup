# General Variables
variable "project" {
  description = "The name of the project or application."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID used to launch the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type (e.g., t2.micro, t3.medium)."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which the EC2 instance will be launched."
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the instance."
  type        = list(string)
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the EC2 instance."
  type        = string
}

# User Data Scripts
variable "user_data_file" {
  description = "Path to the user data script for the main application instance (e.g., Laravel)."
  type        = string
}

variable "node_user_data_file" {
  description = "Path to the user data script for the Node.js background server."
  type        = string
}

# Bastion Host Configuration
variable "create_bastion" {
  description = "Flag to indicate whether to create a Bastion host."
  type        = bool
  default     = false
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion host."
  type        = string
}

variable "bastion_ami_id" {
  description = "AMI ID for the Bastion host."
  type        = string
}

variable "bastion_subnet_id" {
  description = "Subnet ID where the Bastion host should be launched."
  type        = string
}

variable "bastion_sg_id" {
  description = "Security group ID to associate with the Bastion host."
  type        = string
}

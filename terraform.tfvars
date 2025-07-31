aws_region = "us-east-1"

# NETWORK
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]
project              = "devops-laravel-node-app"

# SECURITY GROUP 
bastion_cidr = ["197.211.63.104/32"]

# EC2 for Web App
ami_id        = "ami-08a6efd148b1f7504"
instance_type = "t2.micro"
key_pair_name = "laravel-key"

# Bastion Host Configuration
create_bastion        = true
bastion_ami_id        = "ami-08a6efd148b1f7504"
bastion_instance_type = "t2.micro"

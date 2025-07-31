module "key_pair" {
  source          = "./modules/key_pair"
  key_pair_name   = var.key_pair_name
  public_key_path = var.public_key_path
}

module "iam" {
  source = "./modules/iam"
}

module "network" {
  source               = "./modules/network"
  vpc_cidr             = var.vpc_cidr
  vpc_id               = module.network.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_id     = module.network.public_subnet_ids[0]
  private_subnet_id    = module.network.private_subnet_ids[0]
  availability_zones   = var.availability_zones
  project              = var.project
}

module "security_group" {
  source       = "./modules/security_group"
  project      = var.project
  vpc_id       = module.network.vpc_id
  bastion_cidr = var.bastion_cidr
}

module "ec2" {
  source              = "./modules/ec2"
  project             = var.project
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  subnet_id           = module.network.private_subnet_ids[0]
  security_group_ids  = [module.security_group.web_sg_id]
  key_name            = module.key_pair.key_pair_name
  user_data_file      = "${path.module}/userdata/userdata_laravel.sh"
  node_user_data_file = "${path.module}/userdata/userdata_nodejs.sh"

  # Bastion config block for conditional creation within module
  create_bastion        = var.create_bastion
  bastion_ami_id        = var.bastion_ami_id
  bastion_instance_type = var.bastion_instance_type
  bastion_subnet_id     = module.network.public_subnet_ids[0]
  bastion_sg_id         = module.security_group.bastion_sg_id
}

# I can decide to use a separate Bastion EC2 block instead of managing it inside the main ec2 module
# comment the above Bastion variables in ec2 block and use this one below

# module "bastion" {
#   source             = "./modules/ec2"
#   count              = var.create_bastion ? 1 : 0
#   project            = var.project
#   ami_id             = var.bastion_ami_id
#   instance_type      = var.bastion_instance_type
#   subnet_id          = module.network.public_subnet_ids[0]
#   security_group_ids = [module.security_group.bastion_sg_id]
#   key_name           = module.key_pair.key_pair_name
# }

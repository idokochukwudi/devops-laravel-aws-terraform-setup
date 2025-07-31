output "key_pair_name" {
  value = module.key_pair.key_pair_name
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "web_sg_id" {
  value = module.security_group.web_sg_id
}

output "mysql_sg_id" {
  value = module.security_group.mysql_sg_id
}

output "bastion_instance_id" {
  value = var.create_bastion ? module.ec2.bastion_instance_id : null
}


output "bastion_public_ip" {
  value = var.create_bastion ? module.ec2.bastion_public_ip : null
}



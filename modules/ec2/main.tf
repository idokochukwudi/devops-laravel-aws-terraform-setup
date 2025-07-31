# Laravel App Server
resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = false
  user_data                   = file(var.user_data_file)

  tags = {
    Name = "${var.project}-laravel-server"
    Role = "laravel"
  }
}

# Node.js Server
resource "aws_instance" "node" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = false
  user_data                   = file(var.node_user_data_file)

  tags = {
    Name = "${var.project}-node-server"
    Role = "nodejs"
  }
}

# Bastion Host (optional)
resource "aws_instance" "bastion" {
  count                       = var.create_bastion ? 1 : 0
  ami                         = var.bastion_ami_id
  instance_type               = var.bastion_instance_type
  subnet_id                   = var.bastion_subnet_id
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = "${var.project}-bastion-host"
    Role = "bastion"
  }
}

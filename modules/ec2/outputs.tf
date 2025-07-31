output "laravel_instance_id" {
  value = aws_instance.app.id
}

output "node_instance_id" {
  value = aws_instance.node.id
}

output "laravel_private_ip" {
  value = aws_instance.app.private_ip
}

output "node_private_ip" {
  value = aws_instance.node.private_ip
}

output "bastion_instance_id" {
  value     = var.create_bastion ? aws_instance.bastion[0].id : null
}

output "bastion_public_ip" {
  value     = var.create_bastion ? aws_instance.bastion[0].public_ip : null
}



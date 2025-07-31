output "web_sg_id" {
  description = "ID of the Web Security Group"
  value       = aws_security_group.web_sg.id
}

output "mysql_sg_id" {
  description = "ID of the MySQL Security Group"
  value       = aws_security_group.mysql_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

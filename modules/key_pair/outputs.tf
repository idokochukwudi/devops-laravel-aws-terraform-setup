output "key_pair_name" {
  description = "The name of the created key pair"
  value       = aws_key_pair.this.key_name
}

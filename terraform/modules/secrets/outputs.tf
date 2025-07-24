output "db_secret_arn" {
  description = "The ARN of the DB credentials secret"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "db_secret_name" {
  value = aws_secretsmanager_secret.db_credentials.name
}


output "db_username" {
  description = "Database username"
  value       = var.db_username
}

output "db_password" {
  description = "Database password"
  value       = var.db_password
}

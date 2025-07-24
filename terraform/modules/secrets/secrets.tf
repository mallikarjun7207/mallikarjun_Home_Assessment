resource "aws_secretsmanager_secret" "db_credentials" {
  name       = "dev_db_credentials_${var.environment}"
  kms_key_id = aws_kms_key.secrets_key.arn
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username,
    password = var.db_password
  })
}

resource "aws_kms_key" "secrets_key" {
  description             = "KMS key for encrypting secrets"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}



variable "db_username" {
  type        = string
  description = "Database username to store in Secrets Manager"
}

variable "db_password" {
  type        = string
  description = "Database password to store in Secrets Manager"
  sensitive   = true
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the RDS instance"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for RDS subnet group"
}

variable "db_name" {
  type        = string
  description = "The name of the database"
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, prod)"
}

variable "db_username" {
  type        = string
  description = "Master username for RDS"
}

variable "db_password" {
  type        = string
  description = "Master password for RDS"
  sensitive   = true
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the RDS instance"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "RDS instance type"
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "Storage allocated in GB"
}

variable "storage_type" {
  type        = string
  default     = "gp2"
  description = "Storage type (gp2, io1, etc.)"
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "Database engine (mysql, postgres, etc.)"
}

variable "engine_version" {
  type        = string
  default     = "8.0"
  description = "Database engine version"
}
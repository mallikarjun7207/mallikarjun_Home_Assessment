variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "StrongPassword123!"
}

variable "container_image" {
  description = "Docker image for ECS service"
  type        = string
  default     = "553561694715.dkr.ecr.us-east-1.amazonaws.com/devops-app:latest"
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
  default     = "/ecs/dev-app"
}

variable "alb_log_bucket_prefix" {
  description = "Prefix for ALB log S3 bucket"
  type        = string
  default     = "devops-alb-logs"
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  type        = string
  default     = "devops-assessment-cluster"
}

variable "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}


variable "environment" {
  description = "Deployment environment"
  type        = string
 
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "RDS storage size in GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "RDS storage type"
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "appdb"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "default-devops-assets"
}

variable "s3_versioning_enabled" {
  description = "Whether versioning is enabled on the S3 bucket"
  type        = bool
  default     = true
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  
}

variable "tg_arn" {
  description = "ARN of the target group"
  type        = string
}

############### BACKEND ###############


variable "aws_region" {
  description = "AWS region for backend and provider"
  type        = string
  default     = "us-east-1"
}

variable "backend_bucket_name" {
  description = "S3 bucket name to store the remote state"
  type        = string
}

variable "backend_lock_table" {
  description = "DynamoDB table for state locking"
  type        = string
}

variable "log_group_name" {
  type        = string
  description = "Name of the CloudWatch Log Group"
}

variable "log_retention" {
  type        = number
  description = "Retention in days for CloudWatch logs"
  default     = 7
}

variable "environment" {
  type        = string
  description = "Environment tag"
  default     = "dev"
}

variable "alb_log_bucket_prefix" {
  type        = string
  description = "Prefix for ALB log S3 bucket name"
}

variable "cluster_name" {
  type        = string
  description = "ECS Cluster name"
}

variable "service_name" {
  type        = string
  description = "ECS Service name"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets for ALB"
}

variable "security_groups" {
  type        = list(string)
  description = "Security groups for ALB"
}

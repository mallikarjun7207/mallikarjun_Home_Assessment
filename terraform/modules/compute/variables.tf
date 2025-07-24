variable "vpc_id" {
  type        = string
  description = "VPC ID for the ECS service"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "ecs_execution_role_arn" {
  type        = string
  description = "IAM Role ARN for ECS task execution"
}

variable "alb_listener_arn" {
  type        = string
  description = "Listener ARN for ALB"
}

variable "container_port" {
  type        = number
  default     = 80
  description = "Port on which the container listens"
}

variable "container_image" {
  description = "Docker image for the ECS container"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the ALB target group"
}
variable "ecr_repo_url" {
  type        = string
  description = "ECR repo URL for Docker image"
  default     = "replace-this-with-your-ecr-url" # Optional override
}

variable "service_name" {
  type        = string
  default     = "app-service"
  description = "Name of the ECS service"
}



variable "ecs_service_name" {
  type        = string
  default     = "app-service"
  description = "ECS service name to be used for scaling"
}

variable "ecs_cluster_name" {
  type        = string
  default     = "devops-assessment-cluster"
  description = "ECS cluster name to be used for scaling"
}

variable "min_capacity" {
  type        = number
  default     = 1
  description = "Minimum number of ECS tasks"
}

variable "max_capacity" {
  type        = number
  default     = 4
  description = "Maximum number of ECS tasks"
}

variable "cpu_target_utilization" {
  type        = number
  default     = 70
  description = "Target average CPU utilization for scaling"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "log_group_name" {
  description = "CloudWatch log group name"
  type        = string
  default     = "/ecs/app"
}

variable "log_group_retention_days" {
  description = "Retention period for logs"
  type        = number
  default     = 7
}

variable "db_secret_name" {
  description = "Name of the Secrets Manager secret to be passed to the ECS task"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the IAM role for ECS task execution"
  type        = string
}

variable "secrets_name" {
  description = "Name of the Secrets Manager secret"
  type        = string
}

variable "tg_arn" {
  description = "ARN of the target group"
  type        = string
}
variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution IAM role"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "environment" {
  description = "Environment name for tagging (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

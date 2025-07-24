variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
}

variable "ecr_repo_name" {
  type        = string
  description = "ECR repository name"
}

variable "project_name" {
  description = "Name prefix for backend resources"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

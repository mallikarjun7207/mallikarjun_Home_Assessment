output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "alb_listener_arn" {
  description = "ALB listener ARN"
  value       = aws_lb_listener.app_listener.arn
}

variable "alb_allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Change this default for production
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}


output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.app_tg.arn
}

output "db_security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.db_sg.id
}



output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}



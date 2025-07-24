output "log_group_name" {
  description = "Name of the created CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.ecs_app.name
}

output "alb_log_bucket_name" {
  description = "Name of the S3 bucket used for ALB logs"
  value       = aws_s3_bucket.alb_logs.bucket
}

output "cpu_alarm_name" {
  description = "Name of the CloudWatch alarm for ECS CPU usage"
  value       = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}
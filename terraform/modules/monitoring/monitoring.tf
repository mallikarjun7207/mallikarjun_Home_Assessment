resource "aws_cloudwatch_log_group" "ecs_app" {
  name              = "/ecs/dev-app-${var.environment}"
  retention_in_days = var.log_retention
  skip_destroy      = true

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [retention_in_days]
  }
  tags = {
    Environment = var.environment
    Name        = var.log_group_name
  }
}

resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.alb_log_bucket_prefix}-${random_id.bucket_suffix.hex}"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "alb-log-bucket"
    Environment = var.environment
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "HighCPUUsageECS"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Alarm when ECS CPU exceeds 70%"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
  tags = {
    Environment = var.environment
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "alb_log_policy" {
  bucket = aws_s3_bucket.alb_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AWSALBAccessLogsPolicy"
        Effect = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_logs.arn}/alb/*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })
}

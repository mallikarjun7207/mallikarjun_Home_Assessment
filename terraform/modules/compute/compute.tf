resource "aws_ecs_cluster" "this" {
  name = "devops-assessment-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_role_arn


  container_definitions = jsonencode([
    {
      name  = "app"
      image = var.container_image
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_app.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
      environment = [
        {
          name  = "SECRET_ID"
          value = var.secrets_name

        }
      ]
    }
  ])
}


resource "aws_ecs_service" "app" {
  name            = "${var.service_name}-${var.environment}"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnet_ids
    assign_public_ip = true
    security_groups  = []
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = var.container_port
  }
  depends_on = [aws_ecs_task_definition.app]
}

resource "aws_cloudwatch_log_group" "ecs_app" {
  name              = var.log_group_name
  retention_in_days = var.log_group_retention_days
}
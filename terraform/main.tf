terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "network" {
  source      = "./modules/network"
  environment = var.environment

  alb_allowed_cidrs = ["203.0.113.10/32"] # Your IP, or ["10.0.0.0/16"] for VPC
}

module "iam" {
  source                       = "./modules/iam"
  ecs_task_execution_role_name = "ecsTaskExecutionRole"
  environment                  = "dev"
}


module "secrets" {
  source      = "./modules/secrets"
  environment = var.environment
  db_username = var.db_username
  db_password = var.db_password
}

module "compute" {
  source                   = "./modules/compute"
  vpc_id                   = module.network.vpc_id
  public_subnet_ids        = module.network.public_subnet_ids
  ecs_execution_role_arn   = module.iam.ecs_execution_role_arn
  alb_listener_arn         = module.network.alb_listener_arn
  container_port           = var.container_port
  container_image          = var.container_image
  region                   = var.region
  target_group_arn         = module.network.target_group_arn
  environment              = var.environment
  service_name             = var.service_name
  log_group_name           = "/ecs/${var.environment}-app"
  log_group_retention_days = 7
  db_secret_name           = module.secrets.db_secret_name
  secrets_name             = module.secrets.db_secret_name
  tg_arn                   = module.network.target_group_arn
  ecs_task_role_arn        = module.iam.ecs_execution_role_arn

}

module "database" {
  source             = "./modules/database"
  vpc_id             = module.network.vpc_id
  db_username        = module.secrets.db_username
  db_password        = module.secrets.db_password
  subnet_ids         = module.network.private_subnet_ids
  security_group_ids = [module.network.db_security_group_id]
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage
  storage_type       = var.storage_type
  engine             = var.engine
  engine_version     = var.engine_version
  db_name            = var.db_name
  environment        = var.environment
}

module "s3" {
  source             = "./modules/s3"
  bucket_name        = "${var.s3_bucket_name}-${var.environment}"
  versioning_enabled = var.s3_versioning_enabled
}

output "db_secret_arn" {
  description = "The ARN of the DB credentials secret"
  value       = module.secrets.db_secret_arn
}

output "ecs_task_definition_arn" {
  value = module.compute.ecs_task_definition_arn
}

module "monitoring" {
  source                = "./modules/monitoring"
  log_group_name        = var.log_group_name
  alb_log_bucket_prefix = var.alb_log_bucket_prefix
  cluster_name          = var.ecs_cluster_name
  service_name          = var.service_name
  environment           = var.environment
  subnets               = module.network.public_subnets
  security_groups       = [module.network.alb_sg_id]
}


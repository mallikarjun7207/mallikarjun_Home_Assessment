# DevOps Assessment Project

![CI/CD](https://github.com/mallikarjun7207/DevOps_Assessment-/actions/workflows/ci-cd.yml/badge.svg?branch=main)

This is an automated CI/CD pipeline using Terraform, GitHub Actions, and AWS infrastructure.

This repo contains a complete infrastructure-as-code deployment of a containerized Python app using:

- **Terraform Modules**: Modular VPC, ECS, RDS, IAM, ALB, Secrets, ACM, CloudFront
- **GitHub Actions CI/CD**: Full pipeline for building, testing, and deploying
- **Secure Remote State**: S3 + DynamoDB backend
- **Docker**: For packaging the Python app

## CI/CD Workflow:
- Triggered on every `push` to `main`
- Builds and tests Python app
- Applies Terraform with `terraform.tfvars`

## Project Structure:

├── app/ # Flask application source code
│ ├── main.py # Main application logic
│ ├── wsgi.py # Production server entrypoint (Waitress)
│ └── requirements.txt # Python dependencies
│
├── terraform/ # Root Terraform configuration
│ ├── main.tf
│ ├── outputs.tf
│ ├── variables.tf
│ ├── terraform.tfvars # Injected from GitHub Actions (base64)
│ └── modules/ # Reusable Terraform modules
│ ├── compute/ # ECS cluster, service, task definition
│ ├── network/ # VPC, subnets, routing
│ ├── rds/ # PostgreSQL DB
│ ├── iam/ # IAM roles and policies
│ ├── ecr/ # ECR repository
│ ├── s3/ # S3 for storage (if needed)
│ ├── secrets/ # AWS Secrets Manager
│ └── monitoring/ # CloudWatch logs and alarms
│
├── .github/
│ └── workflows/
│ └── ci-cd.yml # GitHub Actions workflow

**TOOLS USED :**

| Category             | Tool / Service                                                 |
| -------------------- | -------------------------------------------------------------- |
| Cloud Provider       | AWS (ECS, RDS, ECR, IAM, VPC, S3, Secrets Manager, CloudWatch) |
| IaC                  | Terraform (v1.5.7)                                             |
| CI/CD                | GitHub Actions                                                 |
| Runtime              | Docker + ECS Fargate                                           |
| Application Language | Python (Flask)                                                 |
| Web Server           | Waitress (WSGI server)                                         |
| Monitoring           | AWS CloudWatch (Logs & Alarms)                                 |


**INFRASTRUCTURED RESOURCE CREATED**:

VPC with public/private subnets, route tables, and Internet Gateway
ECS Cluster with Fargate service and task definitions
ECR Repository for Docker images
RDS PostgreSQL instance with subnet group and security group
Secrets Manager entry for DB credentials
CloudWatch Log Groups and a CPU Utilization Alarm
IAM Roles for ECS execution and task access
S3 bucket for static assets

**CI/CD PIPELINE AUTOMATE THE FOLLOWING**:

Application build using Docker
Infrastructure validation & provisioning using Terraform
Docker image push to Amazon ECR
Deployment to AWS ECS Fargate
Secrets are securely handled via GitHub Actions + AWS Secrets Manager

**Secrets Management Strategy**:

To manage application secrets such as the PostgreSQL database password, this project uses:
AWS Secrets Manager for storing and rotating secrets
Terraform to provision secrets securely and inject them into the ECS task definition as environment variables
GitHub Secrets for secure pipeline access to infrastructure via AWS credentials and .tfvars injection

**Why This Approach?**:

Secure: Secrets are not hardcoded and are stored encrypted in AWS Secrets Manager
Least Privilege: IAM roles restrict access to secrets only for the ECS task
Scalable: Can handle additional secrets like API keys or tokens easily
CI/CD Compatible: GitHub Actions does not handle application secrets — they are injected at runtime only

**Deliverables Summary**:
 Secrets stored in AWS Secrets Manager
 Injected into ECS via environment variables
 Used securely in Flask application
 All managed through Terraform

**Monitoring and Observability**:

To monitor the application health and performance, this project implements:
AWS CloudWatch Logs for all container output from ECS tasks
AWS CloudWatch Metrics for ECS service-level CPU usage
An alert condition for high CPU utilization using CloudWatch Alarms

**Logging Configuration**:
All ECS containers are configured to log to a centralized log group using the AWS awslogs driver in Terraform.

**The task definition uses this log group:**
Logs from stdout and stderr of your Flask app are sent here automatically.

**CloudWatch Metrics + Alarm**:
We monitor CPU utilization of the ECS service and define an alarm if it goes above 80% for 2 consecutive minutes.

**Notifications**:
alarm can be connected to an SNS topic which can email DevOps or trigger automated remediation.

**Summary**:

 Application logs centralized via CloudWatch Logs
 ECS service CPU usage monitored via CloudWatch Metrics
 Alert condition defined (CPU > 80% for 2 min)
 Optional SNS notification configuration included

**DEPLOYMENT TARGET**:
After pushing the image to ECR, the ECS service (provisioned by Terraform) automatically pulls the updated image and redeploys the container.

**DELIVERABLES SUMMARY**:

 CI/CD pipeline file: .github/workflows/ci-cd.yml
 Secure secret injection via GitHub Secrets and Secrets Manager
 Terraform validation, plan, apply
 Docker image built and pushed to ECR
 Auto-deployment to ECS Fargate service

**ASSUMPTIONS MADE **:

The application is not serving static assets, so no CDN or S3 integration was needed.
Using Secrets Manager to store database credentials.
CI/CD assumes that the branch name (main, dev, staging) aligns with environment names and ECR tags.
Default VPC CIDRs and public subnets are sufficient for the test scope.

**KNOWN LIMITATIONS ** :

ALB is configured for HTTP only (no HTTPS or ACM configured).
No RDS Proxy implemented (optional for small applications).
The database credentials are stored in AWS Secrets Manager but not rotated dynamically.
Blue/Green deployments or Canary are not yet implemented.

**REFLECTIONS**:

Modular Terraform Code: Broke down infrastructure into modules for compute, network, IAM, etc., for reusability.
Waitress Instead of Gunicorn: Chosen for cross-platform compatibility with Windows during local testing.
GitHub Actions with Environment-Specific Logic: Dynamic tagging and conditional apply only on main.

**WHY I MADE THESE DECISIONS**:

Modularity and clarity enhance maintainability and allow easier environment cloning.
Waitress works out of the box without Linux-only dependencies.
CI/CD required secure automation, so dynamic ECR tagging, branch filtering, and Terraform state management were essential.

**TRADE-OFFS CONSIDERED**:

Using ECS Fargate simplified infrastructure at the cost of flexibility compared to EC2.
Not implementing HTTPS offloads the complexity, but would be necessary for production.
Using AWS Secrets Manager is more secure than hardcoded secrets, but a full rotation strategy isn’t in place
Python dependencies are locked via requirements.txt.

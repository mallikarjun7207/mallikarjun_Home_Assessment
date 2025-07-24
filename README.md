# DevOps Assessment Project

# DevOps Assessment

![CI/CD](https://github.com/mallikarjun7207/DevOps_Assessment-/actions/workflows/ci-cd.yml/badge.svg?branch=main)

This is an automated CI/CD pipeline using Terraform, GitHub Actions, and AWS infrastructure.


This repo contains a complete infrastructure-as-code deployment of a containerized Python app using:

- **Terraform Modules**: Modular VPC, ECS, RDS, IAM, ALB, Secrets, ACM, CloudFront
- **GitHub Actions CI/CD**: Full pipeline for building, testing, and deploying
- **Secure Remote State**: S3 + DynamoDB backend
- **Docker**: For packaging the Python app

## CI/CD Workflow
- Triggered on every `push` to `main`
- Builds and tests Python app
- Applies Terraform with `terraform.tfvars`

## Project Structure


terraform {
  backend "s3" {
    bucket         = "devops-assessment-dev-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-assessment-dev-tf-lock"

  }
}

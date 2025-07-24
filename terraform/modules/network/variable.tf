

# variable "vpc_cidr" {
#   type        = string
#   default     = "10.0.0.0/16"
#   description = "CIDR block for the VPC"
# }

# variable "public_subnet_cidrs" {
#   type        = list(string)
#   description = "List of CIDRs for public subnets"
#   default     = ["10.0.1.0/24", "10.0.2.0/24"]
# }

# variable "private_subnet_cidrs" {
#   type        = list(string)
#   description = "List of CIDRs for private subnets"
#   default     = ["10.0.3.0/24", "10.0.4.0/24"]
# }

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod, staging)"
}



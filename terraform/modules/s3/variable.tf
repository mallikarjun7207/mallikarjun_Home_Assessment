variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable versioning for the S3 bucket"
  default     = true
}

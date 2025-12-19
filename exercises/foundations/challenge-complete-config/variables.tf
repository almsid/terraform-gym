variable "aws_region" {
  type        = string
  description = "AWS region to deploy to"
  default     = "us-east-1"
}
variable "environment" {
  type = string
  validation {
    condition     = var.environment == "dev" || var.environment == "prod" || var.environment == "staging"
    error_message = "environment must be dev or prod or staging"
  }
  description = "Environment to deploy to: dev, prod, or staging"
}
variable "project_name" {
  type        = string
  default     = "terraform-gym"
  description = "Name of the project"
}
variable "bucket_count" {
  type = number
  validation {
    condition     = var.bucket_count > 0 && var.bucket_count < 5
    error_message = "bucket_count must be between 1 and 4"
  }
  description = "Number of S3 buckets to create"
}
variable "enable_encryption" {
  type        = bool
  default     = true
  description = "Enable encryption for S3 buckets"
}

variable "common_tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
  default = {
    owner      = "terraform-gym"
    created_by = "terraform-gym"
    created_at = "terraform-gym"
    updated_at = "terraform-gym"
    version    = "terraform-gym"
  }
}

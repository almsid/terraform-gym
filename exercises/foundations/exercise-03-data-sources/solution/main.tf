# Exercise 03: Data Sources

terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source: Get current AWS account information
data "aws_caller_identity" "current" {}

# Data source: Get current region
data "aws_region" "current" {}

# Data source: Get available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create S3 bucket using data from data sources
resource "aws_s3_bucket" "example" {
  # Use account ID and region in bucket name for uniqueness
  bucket        = "terraform-gym-03-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  force_destroy = true

  tags = {
    Name        = "Exercise 03 Data Sources Bucket"
    Environment = "Learning"
    ManagedBy   = "Terraform"
    AccountID   = data.aws_caller_identity.current.account_id
    Region      = data.aws_region.current.name
    AZCount     = length(data.aws_availability_zones.available.names)
    FirstAZ     = data.aws_availability_zones.available.names[0]
  }
}

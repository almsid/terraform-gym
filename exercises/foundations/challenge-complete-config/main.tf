terraform {
  required_version = ">= 1.5.7"
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

data "aws_caller_identity" "get_account_id" {}
data "aws_region" "get_current_region" {}
data "aws_availability_zones" "get_list_of_zones" {}

locals {
  bucket_name_prefix  = "${var.project_name}-${var.environment}"
  resource_identifier = "${data.aws_caller_identity.get_account_id.account_id}-${data.aws_region.get_current_region.name}"
  all_tags = merge(
    var.common_tags,
    {
      environment         = var.environment
      project             = var.project_name
      resource_identifier = local.resource_identifier
    }
  )
}

resource "aws_s3_bucket_versioning" "versioning" {
  count  = var.bucket_count
  bucket = aws_s3_bucket.bucket[count.index].id
  versioning_configuration {
    status = var.enable_encryption ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  count  = var.enable_encryption ? 1 : 0
  bucket = aws_s3_bucket.bucket[count.index].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  count  = var.bucket_count
  bucket = "${local.bucket_name_prefix}-${count.index}-${data.aws_caller_identity.get_account_id.account_id}"

}



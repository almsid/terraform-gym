output "bucket_name" {
  value = [for bucket in aws_s3_bucket.bucket : bucket.id]
}

output "bucket_arn" {
  value = [for bucket in aws_s3_bucket.bucket : bucket.arn]
}

output "aws_account_id" {
  value = data.aws_caller_identity.get_account_id.account_id
}

output "aws_region" {
  value = data.aws_region.get_current_region.name
}

output "common_tags" {
  value = local.all_tags
}

output "environment" {
  value = var.environment
}

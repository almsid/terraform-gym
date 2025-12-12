# Outputs for Exercise 02

# TODO: Add output for bucket name
output "bucket_name" {
  description = "Bucket name"
  value       = aws_s3_bucket.example.bucket
}

# TODO: Add output for bucket ARN
output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.example.arn
}
# TODO: Add output for bucket region
output "bucket_region" {
  description = "Bucket region"
  value       = aws_s3_bucket.example.region
}
# TODO: Add output for all tags (mark as sensitive for practice)
output "bucket_tags" {
  description = "Bucket tags"
  value       = aws_s3_bucket.example.tags
  sensitive   = true
}

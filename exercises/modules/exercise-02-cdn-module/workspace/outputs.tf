# =============================================================================
# ROOT MODULE - OUTPUTS
# =============================================================================

# S3 Website outputs (still useful for debugging)
output "s3_website_url" {
  description = "Direct S3 website URL (HTTP only, for debugging)"
  value       = module.website.website_url
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.website.bucket_id
}

# CDN outputs (what users should actually use)
output "cdn_url" {
  description = "CloudFront CDN URL (HTTPS) - USE THIS!"
  value       = module.cdn.cdn_url
}

output "distribution_id" {
  description = "CloudFront distribution ID (for cache invalidation)"
  value       = module.cdn.distribution_id
}

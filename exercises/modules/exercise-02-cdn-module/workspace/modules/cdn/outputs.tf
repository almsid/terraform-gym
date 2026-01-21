# =============================================================================
# CDN MODULE - OUTPUTS
# =============================================================================
# TODO: Define outputs that callers will need
#
# Think about:
# - What identifier might someone need to invalidate the cache?
# - What URL will users access?
# - What ARN might be needed for IAM policies?
# =============================================================================

output "distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.arn
}

output "distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cdn_url" {
  description = "The HTTPS URL of the CDN"
  value       = "https://${aws_cloudfront_distribution.this.domain_name}"
}

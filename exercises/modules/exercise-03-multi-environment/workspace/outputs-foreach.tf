output "all_cdn_urls_foreach" {
  description = "All CloudFront URLs (for_each version)"
  value = {
    for env, cdn in module.cdns : env => cdn.cdn_url
  }
}

output "all_buckets_foreach" {
  description = "All S3 buckets (for_each version)"
  value = {
    for env, website in module.websites : env => website.bucket_id
  }
}

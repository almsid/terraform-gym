output "website_url" {
  description = "URL of the dev website"
  value       = module.dev_website.website_url
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.dev_website.bucket_id
}

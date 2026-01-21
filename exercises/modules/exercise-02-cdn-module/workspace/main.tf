# =============================================================================
# ROOT MODULE - Exercise 02 Solution
# =============================================================================
# This demonstrates MODULE COMPOSITION - modules working together.
# The CDN module depends on outputs from the S3 website module.
# =============================================================================

# -----------------------------------------------------------------------------
# S3 Website Module
# -----------------------------------------------------------------------------
module "website" {
  source = "./modules/s3-website"

  bucket_name = "acme-marketing-dev-${var.unique_suffix}"
  environment = "dev"

  site_content = {
    heading          = "Development Preview"
    message          = "This is the internal development environment. Now with CloudFront CDN!"
    background_color = "#e3f2fd"
    badge_color      = "#1976d2"
  }

  tags = {
    Team    = "marketing"
    Project = "campaign-preview"
  }
}

# -----------------------------------------------------------------------------
# CloudFront CDN Module
# -----------------------------------------------------------------------------
# Notice how we pass the S3 module's output as input to this module!
# This creates an implicit dependency: CDN waits for S3 to be created.
# -----------------------------------------------------------------------------
module "cdn" {
  source = "./modules/cdn"

  # THE KEY WIRING: S3 output → CDN input
  origin_domain = module.website.website_endpoint
  environment   = "dev"

  tags = {
    Team    = "marketing"
    Project = "campaign-preview"
  }
}

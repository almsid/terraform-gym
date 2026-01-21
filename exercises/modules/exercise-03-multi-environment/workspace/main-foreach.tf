# =============================================================================
# MULTI-ENVIRONMENT DEPLOYMENT WITH for_each
# =============================================================================
# This is a refactored version that eliminates repetition.
# Compare this to main.tf to see the difference!
# =============================================================================
locals {
  environments = {
    dev = {
      site_content = {
        heading          = "Development Preview"
        message          = "Internal testing environment for the development team."
        background_color = "#e3f2fd" # Light blue
        badge_color      = "#1976d2" # Blue
      }
      enable_versioning = false # Don't need versioning in dev
    }

    staging = {
      site_content = {
        heading          = "Staging Review"
        message          = "Pre-production environment for stakeholder review."
        background_color = "#fff8e1" # Light yellow/amber
        badge_color      = "#f57c00" # Orange
      }
      enable_versioning = false # Optional for staging
    }

    prod = {
      site_content = {
        heading          = "Welcome to Acme Corp"
        message          = "Official company website. Handle with care!"
        background_color = "#e8f5e9" # Light green
        badge_color      = "#388e3c" # Green
      }
      enable_versioning = true # ALWAYS version production!
    }
    qa = {
      site_content = {
        heading          = "QA Testing"
        message          = "Quality Assurance testing environment."
        background_color = "#e1bee7" # Light purple
        badge_color      = "#9c27b0" # Purple
      }
      enable_versioning = false
    }
  }
}
# -----------------------------------------------------------------------------
# S3 Website Module - One call creates ALL environments
# -----------------------------------------------------------------------------
module "websites" {
  source = "./modules/s3-website"

  for_each = local.environments

  bucket_name       = "acme-${each.key}-${var.unique_suffix}"
  environment       = each.key
  site_content      = each.value.site_content
  enable_versioning = each.value.enable_versioning
  tags = {
    Team        = "marketing"
    Project     = "campaign-preview"
    Environment = each.key
  }
}

# -----------------------------------------------------------------------------
# CloudFront CDN Module - One call creates ALL environments
# -----------------------------------------------------------------------------
module "cdns" {
  source = "./modules/cdn"

  for_each = local.environments

  origin_domain = module.websites[each.key].website_endpoint
  environment   = each.key
  tags = {
    Team        = "marketing"
    Project     = "campaign-preview"
    Environment = each.key
  }
}

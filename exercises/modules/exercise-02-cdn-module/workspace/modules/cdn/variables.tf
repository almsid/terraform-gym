# =============================================================================
# CDN MODULE - INPUT VARIABLES
# =============================================================================
# TODO: Define the input variables this module needs
#
# Think about:
# - What does CloudFront need to know about the origin (S3)?
# - What environment is this for?
# - What configuration might change between environments?
# =============================================================================

# =============================================================================
# CDN MODULE - INPUT VARIABLES
# =============================================================================

variable "origin_domain" {
  description = "Domain name of the origin (S3 website endpoint)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "price_class" {
  description = "CloudFront price class (PriceClass_100, PriceClass_200, PriceClass_All)"
  type        = string
  default     = "PriceClass_100" # US, Canada, Europe only - cheapest

  validation {
    condition     = contains(["PriceClass_100", "PriceClass_200", "PriceClass_All"], var.price_class)
    error_message = "Price class must be PriceClass_100, PriceClass_200, or PriceClass_All."
  }
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

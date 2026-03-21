data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

# We are using the same certificate created for frontend ALB for CloudFront distribution as well.
data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project}-${var.environment}/frontend_alb_certificate_arn"
}
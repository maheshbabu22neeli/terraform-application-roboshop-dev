resource "aws_cloudfront_distribution" "roboshop" {

  origin {
    # frontend-dev.neeli.online   --> this orgin is used to route traffic to the frontend ALB
    domain_name = "frontend-${var.environment}.${var.domain_name}"
    origin_id   = "frontend-${var.environment}.${var.domain_name}"

    custom_origin_config {
      http_port              = 80 // required to set, but not used since we're using https-only
      https_port             = 443
      origin_protocol_policy = "https-only" # or "http-only"
      origin_ssl_protocols   = ["TLSv1.1", "TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = false
  comment         = "CloudFront for Frontend ALB"

  # this is actual CDN URL which will be used by users to access the frontend application, and this is also used in Route53 record
  aliases = [
    # https://roboshop-dev.neeli.online
    "${var.project}-${var.environment}.${var.domain_name}"
  ]

  default_cache_behavior {
    target_origin_id       = "frontend-${var.environment}.${var.domain_name}"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "https-only"
    cache_policy_id        = local.caching_disabled

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # this cache behavior is for media files, precedence - 0
  ordered_cache_behavior {
    target_origin_id       = "frontend-${var.environment}.${var.domain_name}"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    path_pattern           = "/media/*"
    viewer_protocol_policy = "https-only"
    cache_policy_id        = local.caching_optimized
  }

  # this cache behavior is for images files, precedence - 1
  ordered_cache_behavior {
    target_origin_id       = "frontend-${var.environment}.${var.domain_name}"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    path_pattern           = "/images/*"
    viewer_protocol_policy = "https-only"
    cache_policy_id        = local.caching_optimized
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = local.acm_certificate_arn
    ssl_support_method             = "sni-only"
    cloudfront_default_certificate = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-frontend"
    }
  )
}

resource "aws_route53_record" "cdn" {
  zone_id = var.zone_id
  name    = "${var.project}-${var.environment}.${var.domain_name}"
  type    = "A"

  # these are related to load balancer details
  alias {
    name                   = aws_cloudfront_distribution.roboshop.domain_name
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = true
  }
}

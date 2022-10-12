resource "aws_s3_bucket" "meta-photos-website-meta_photos" {
  bucket = var.meta_photos_domain
  acl = "public-read"

  tags = {
    Usage       = var.Usage
    Environment = var.environment
  }

  # cors_rule {
  #   allowed_headers = ["*"]
  #   allowed_methods = ["PUT","POST"]
  #   allowed_origins = ["*"]
  #   expose_headers = ["ETag"]
  #   max_age_seconds = 3000
  # }

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.meta_photos_domain}/*"
        }
      ]
    }
EOF

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}
resource "aws_s3_bucket_public_access_block" "storage_4dx_policy" {
  bucket = aws_s3_bucket.meta-photos-website-meta_photos.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
## ACCESS IDENTITY
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${var.meta_photos_domain}"
} 

resource "aws_cloudfront_distribution" "meta_photos_distribution" {
  origin {
    domain_name = aws_s3_bucket.meta-photos-website-meta_photos.bucket_domain_name
    origin_id   = "S3-Website-${var.meta_photos_domain}${var.meta_photos_bucket}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Managed by Terraform"
  default_root_object = "/index.html"
  
  aliases = ["*.${var.meta_photos_domain}"]
  price_class = "PriceClass_All"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-Website-${var.meta_photos_domain}${var.meta_photos_bucket}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  custom_error_response{
    error_caching_min_ttl = 10
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.meta_photos_certificate
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }
  #  viewer_certificate {
  #   cloudfront_default_certificate = true
  # }

  tags = {
    Usage       = var.Usage
    Environment = var.environment
  }
}
data "aws_iam_policy_document" "s3_meta_photos_meta_photos_iam_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.meta-photos-website-meta_photos.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_meta_photos_meta_photos_bucket_policy" {
  bucket = aws_s3_bucket.meta-photos-website-meta_photos.id
  policy = data.aws_iam_policy_document.s3_meta_photos_meta_photos_iam_policy.json
  depends_on = [
    aws_s3_bucket.meta-photos-website-meta_photos,
  ]
}
########################### RECORD FOR ROUTE53 ###########################

# Add record on the Route53 HostedZone to point the ALb or S3 Bucket where is the front-end of the application
resource "aws_route53_record" "record_apis_alb" {
  zone_id = var.gestor_hz
  name    = "www.${var.meta_photos_domain}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.meta_photos_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.meta_photos_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
output "meta_photos_website_meta_photos" {
  value = aws_s3_bucket.meta-photos-website-meta_photos.website_endpoint
}
output "meta_photos_website-meta_photos_arn" {
  value = aws_s3_bucket.meta-photos-website-meta_photos.arn
}
output "distribution_meta_photos" {
  value = aws_cloudfront_distribution.meta_photos_distribution.id
}

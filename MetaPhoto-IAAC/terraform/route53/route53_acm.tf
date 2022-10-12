######################################### GESTOR DOMAIN #########################################

# ROUTE53 HOSTED ZONE
resource "aws_route53_zone" "meta-photos-gestor-domain" {
  name = var.gestor_domain

  tags = {
    Name        =  "meta-photos-HostedZone"
    Usage       = var.Usage
    Environment = var.environment
    
  }
}

# CERTIFICATE MANAGER
resource "aws_acm_certificate" "meta-photos-gestor-certificate" {
  domain_name       = "www.${var.gestor_domain}"
  validation_method = "DNS"

  tags = {
    Name        =  "www-meta-photos-Certificate"
    Usage       = var.Usage
    Environment = var.environment
    
  }
}
resource "aws_acm_certificate" "meta-photos-gestor-certificate-api" {
  domain_name       = "api.${var.gestor_domain}"
  validation_method = "DNS"

  tags = {
    Name        =  "meta-photos-Certificate"
    Usage       = var.Usage
    Environment = var.environment
    
  }
}

# Adding SSL record to Route53 Hosted Zone
 resource "aws_route53_record" "meta-photos-cert-validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.meta-photos-gestor-certificate.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.meta-photos-gestor-certificate.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.meta-photos-gestor-certificate.domain_validation_options)[0].resource_record_type
  zone_id         = aws_route53_zone.meta-photos-gestor-domain.id
  ttl             = 300
}
 resource "aws_route53_record" "meta-photos-api-cert-validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.meta-photos-gestor-certificate-api.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.meta-photos-gestor-certificate-api.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.meta-photos-gestor-certificate-api.domain_validation_options)[0].resource_record_type
  zone_id         = aws_route53_zone.meta-photos-gestor-domain.id
  ttl             = 300
}
/* resource "aws_route53_record" "gestor-cert-validation-net" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.meta-photos-gestor-certificate-net.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.meta-photos-gestor-certificate-net.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.meta-photos-gestor-certificate-net.domain_validation_options)[0].resource_record_type
  zone_id         = aws_route53_zone.meta-photos-gestor-domain-net.id
  ttl             = 300
} */

# # Add record on the Route53 HostedZone to point the ALb or S3 Bucket where is the front-end of the application
# resource "aws_route53_record" "myapp" {
#   zone_id = data.aws_route53_zone.public.zone_id
#   name    = "${var.demo_dns_name}.${data.aws_route53_zone.public.name}"
#   type    = "A"
#   alias {
#     name                   = aws_alb.mylb.dns_name
#     zone_id                = aws_alb.mylb.zone_id
#     evaluate_target_health = false
#   
#   provider = aws.account_route53
# }



# OUTPUTS
output "gestor_hz" {
  value = aws_route53_zone.meta-photos-gestor-domain.id
}
output "app_certificate_net_arn" {
  value = aws_acm_certificate.meta-photos-gestor-certificate.arn
}
output "api_certificate_net_arn" {
  value = aws_acm_certificate.meta-photos-gestor-certificate-api.arn
}

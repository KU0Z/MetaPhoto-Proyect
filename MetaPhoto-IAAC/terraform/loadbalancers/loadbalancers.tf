# APIs LOAD BALANCER
resource "aws_alb" "meta-photos-apis-lb" {
  name                       = "meta-photos-apis-lb"
  internal                   = false
  ip_address_type            = "ipv4"
  load_balancer_type         = "application"
  enable_deletion_protection = false
  security_groups            = [var.security_group]
  subnets                    = [var.public_subnet_1, var.public_subnet_2]

  tags = {
    Name        = "meta-photos-apis-lb",
    Usage       = var.Usage
    Environment = var.environment
    
  }
}

# TARGET GROUPS

# Target Group meta-photos
resource "aws_alb_target_group" "meta-photos-api-tg" {
  name        = "meta-photos-api-tg"
  port        = var.app_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc

  health_check {
    healthy_threshold   = "3"
    interval            = "40"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "10"
    path                = "/api/externalapi/healthcheck"
    unhealthy_threshold = "3"
  }

  tags = {
    Name        = "meta-photos-api-tg",
    Usage       = var.Usage
    Environment = var.environment
    
  }
}


# LISTENERS

# Load Balancer Listener HTTP
resource "aws_alb_listener" "meta-photos-apis-backend-listener-http" {
  load_balancer_arn   = aws_alb.meta-photos-apis-lb.arn
  port                = var.app_port
  protocol            = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Load Balancer Listener HTTPS
resource "aws_alb_listener" "meta-photos-apis-backend-listener-https" {
  load_balancer_arn   = aws_alb.meta-photos-apis-lb.arn
  port                = "443"
  protocol            = "HTTPS"
  certificate_arn     = var.photos_certificate

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "Fixed response content"
      status_code  = "404"
    }
  }
}

# Listener rule for api
resource "aws_lb_listener_rule" "meta-photos-api-listener" {
  listener_arn = aws_alb_listener.meta-photos-apis-backend-listener-https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.meta-photos-api-tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}



########################### RECORD FOR ROUTE53 ###########################

# Add record on the Route53 HostedZone to point the ALb or S3 Bucket where is the front-end of the application
/* resource "aws_route53_record" "record_apis_alb" {
  zone_id = var.gestor-hz
  name    = "apis.${var.gestor_domain}"
  type    = "A"
  alias {
    name                   = aws_alb.meta-photos-apis-lb.dns_name
    zone_id                = aws_alb.meta-photos-apis-lb.zone_id
    evaluate_target_health = true
  }
} */
resource "aws_route53_record" "record_apis_alb_net" {
  zone_id = var.hotedZone
  name    = "api.${var.photos_domain}"
  type    = "A"
  alias {
    name                   = aws_alb.meta-photos-apis-lb.dns_name
    zone_id                = aws_alb.meta-photos-apis-lb.zone_id
    evaluate_target_health = true
  }
}

# OUTPUTS
output "api_meta_photos_tg" {
  value = aws_alb_target_group.meta-photos-api-tg.id
}
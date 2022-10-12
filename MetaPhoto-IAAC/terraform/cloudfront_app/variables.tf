
# AWS TAGS
variable "Usage" {
}
variable "environment" {

}

# ref https://docs.aws.amazon.com/general/latest/gr/rande.html
# examples:
# US East (Ohio)	          us-east-2	
# US East (N. Virginia)	    us-east-1
# US West (Oregon)	        us-west-2	
# US West (N CAlifornia)    us-west-1
variable "aws_region" {
}



# EXTERNAL SOURCE

# S3 Bucket
variable "meta_photos_bucket" {
}

# Certificate
variable "meta_photos_certificate" {
}

# Gestor Domain
variable "meta_photos_domain" {
}

# Gestor HostedZone
variable "gestor_hz" {
}
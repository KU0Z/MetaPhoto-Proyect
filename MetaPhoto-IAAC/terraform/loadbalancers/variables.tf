# AWS CREDENTIALS

# AWS TAGS
variable "Usage" {
  
}
variable "environment" {
  
}

# APPLICATION PORT
variable "app_port" {
}

# ref https://docs.aws.amazon.com/general/latest/gr/rande.html
# examples:
# US East (Ohio)	          us-east-2	
# US East (N. Virginia)	    us-east-1
# US West (Oregon)	        us-west-2	
# US West (N CAlifornia)    us-west-1
variable "aws_region" {
  
}
variable "aws_availability_zone1" {
  
}
variable "aws_availability_zone2" {
  
}

# EXTERNAL SOURCE

# Security Group
variable "security_group" {
  
}

# Networking
variable "vpc" {
  
}
variable "public_subnet_1" {
  
}
variable "public_subnet_2" {
  
}

# Certificate
variable "photos_certificate" {
  
}


# Gestor HostedZone
variable "hotedZone" {
  
}

variable "photos_domain" {
  
}
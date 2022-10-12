variable "projectName" {}
# VPC CONFIGURATIONS
variable "instanceTenancy" {}
variable "dnsSupport" {}
variable "dnsHostNames" {}
variable "vpcClassicLink" {}
variable "app_port" {}

# SUBNETS CONFIGURATIONS
variable "vpcCIDRblock" {}
variable "private-subnet-1-CIDR" {}
variable "private-subnet-2-CIDR" {}
variable "api-meta-photos-subnet-1-CIDR" {}
variable "api-meta-photos-subnet-2-CIDR" {}
variable "db-subnet-1-CIDR" {}
variable "db-subnet-2-CIDR" {}


# AWS CREDENTIALS

# AWS TAGS
variable "Usage" {}
variable "environment" {}

# ref https://docs.aws.amazon.com/general/latest/gr/rande.html
# examples:
# US East (Ohio)	          us-east-2	
# US East (N. Virginia)	    us-east-1
# US West (Oregon)	        us-west-2	
# US West (N CAlifornia)    us-west-1
variable "aws_region" {}
variable "aws_availability_zone1" {}
variable "aws_availability_zone2" {}
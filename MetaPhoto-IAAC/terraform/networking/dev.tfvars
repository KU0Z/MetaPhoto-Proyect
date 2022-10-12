projectName="UAD"

# VPC CONFIGURATIONS
instanceTenancy="default"
dnsSupport= true
dnsHostNames= true
vpcClassicLink= false
app_port= 80

# SUBNETS CONFIGURATIONS
vpcCIDRblock="172.31.0.0/16"
api-meta-photos-subnet-1-CIDR="172.31.1.0/27"
api-meta-photos-subnet-2-CIDR="172.31.1.32/27"
public-subnet-1-CIDR="172.31.1.64/27"
public-subnet-2-CIDR="172.31.1.96/27"
db-subnet-1-CIDR="172.31.1.128/27"
db-subnet-2-CIDR="172.31.1.160/27"


# AWS CREDENTIALS

# AWS TAGS
Usage="meta-photos"
environment="QA"

# ref https://docs.aws.amazon.com/general/latest/gr/rande.html
# examples:
# US East (Ohio)	          us-east-2	
# US East (N. Virginia)	    us-east-1
# US West (Oregon)	        us-west-2	
# US West (N CAlifornia)    us-west-1
aws_region="us-east-2"
aws_availability_zone1="us-east-2a"
aws_availability_zone2="us-east-2b"

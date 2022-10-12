# VPC
resource "aws_vpc" "meta-photos-main-vpc" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
  enable_classiclink   = var.vpcClassicLink

  tags = {
    
    Name        = "meta-photos-main-vpc",
    Usage       = var.Usage
    Environment = var.environment
  }
}

# api-meta-photos Subnets
resource "aws_subnet" "api-meta-photos-subnet-1" {
  vpc_id            = aws_vpc.meta-photos-main-vpc.id
  cidr_block        = var.api-meta-photos-subnet-1-CIDR
  availability_zone = var.aws_availability_zone1

  tags = {
    
    Name        = "meta-photos-api-meta-photos-subnet-1",
    Usage       = var.Usage
    Environment = var.environment
  }
}
resource "aws_subnet" "api-meta-photos-subnet-2" {
  vpc_id            = aws_vpc.meta-photos-main-vpc.id
  cidr_block        = var.api-meta-photos-subnet-2-CIDR
  availability_zone = var.aws_availability_zone2

  tags = {
    
    Name        = "meta-photos-api-meta-photos-subnet-2",
    Usage       = var.Usage
    Environment = var.environment
  }
}

# Public Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.meta-photos-main-vpc.id
  cidr_block        = var.public-subnet-1-CIDR
  availability_zone = var.aws_availability_zone1

  tags = {
    
    Name        = "meta-photos-public-subnet-1",
    Usage       = var.Usage
    Environment = var.environment
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.meta-photos-main-vpc.id
  cidr_block        = var.public-subnet-2-CIDR
  availability_zone = var.aws_availability_zone2

  tags = {
    
    Name        = "meta-photos-public-subnet-2",
    Usage       = var.Usage
    Environment = var.environment
  }
}
# INTERNET GATEWAY
resource "aws_internet_gateway" "meta-photos-internet-gateway" {
  vpc_id = aws_vpc.meta-photos-main-vpc.id

  tags = {
    
    Name        = "meta-photos-internet-gateway",
    Usage       = var.Usage
    Environment = var.environment
  }
}




# Public Route Table
resource "aws_route_table" "meta-photos-route-table-public" {
  vpc_id = aws_vpc.meta-photos-main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.meta-photos-internet-gateway.id
  }

  tags = {
    
    Name        = "meta-photos-route-table-public",
    Usage       = var.Usage
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public-subnet-1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.meta-photos-route-table-public.id
}

resource "aws_route_table_association" "public-subnet-2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.meta-photos-route-table-public.id
}
resource "aws_route_table_association" "api-meta-photos-subnet-1-association" {
  subnet_id      = aws_subnet.api-meta-photos-subnet-1.id
  route_table_id = aws_route_table.meta-photos-route-table-public.id
}
resource "aws_route_table_association" "api-meta-photos-subnet-2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.meta-photos-route-table-public.id
}

# SECURITY GROUP
resource "aws_security_group" "meta-photos-security-group" {
  name        = "meta-photos-security-group"
  description = " mainly for restfull apis and web"
  vpc_id      = aws_vpc.meta-photos-main-vpc.id
  ingress {
    description      = ""
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = ""
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description      = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
    self = true
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    
    Name        = "meta-photos-security-group",
    Usage       = var.Usage
    Environment = var.environment
  }
}
resource "aws_security_group" "meta-photos-security-group-api" {
  name        = "meta-photos-api-security-group"
  description = "acces api"
  vpc_id      = aws_vpc.meta-photos-main-vpc.id
  ingress {
    description      = "loadbalancer"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.meta-photos-security-group.id]
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    
    Name        = "meta-photos-security-group-db",
    Usage       = var.Usage
    Environment = var.environment
  }
}
# OUTPUTS
output "security_group_load" {
  value = aws_security_group.meta-photos-security-group.id
}
# OUTPUTS
output "security_group_api" {
  value = aws_security_group.meta-photos-security-group-api.id
}

output "vpc" {
  value = aws_vpc.meta-photos-main-vpc.id
}
output "api_meta_photos_subnet_1" {
  value = aws_subnet.api-meta-photos-subnet-1.id
}
output "api_meta_photos_subnet_2" {
  value = aws_subnet.api-meta-photos-subnet-2.id
}
output "public_subnet_1" {
  value = aws_subnet.public-subnet-1.id
}
output "public_subnet_2" {
  value = aws_subnet.public-subnet-2.id
}
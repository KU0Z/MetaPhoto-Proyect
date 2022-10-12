resource "aws_ecr_repository" "meta-photo-api" {
  name = "meta-photo-api"
  tags = {
    Usage       = var.Usage
    Environment = var.environment
  }
}
# OUTPUTS
output "ecr-meta-photos-api-polls" {
  value = aws_ecr_repository.meta-photo-api.repository_url
}

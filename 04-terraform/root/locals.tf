locals {
  name_prefix = "${var.environment}-${var.service_name}"

  common_tags = {
    Environment = var.environment
    Service     = var.service_name
    ManagedBy   = "terraform"
  }
}

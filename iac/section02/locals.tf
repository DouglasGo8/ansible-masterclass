locals {
  owners      = var.project_name
  environment = var.environment 
  #
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}

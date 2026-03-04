module "vpc" {
  source = "git::https://github.com/maheshbabu22neeli/terraform-platform.git//aws-vpc?ref=main"
  project = var.project
  environment = var.environment
  is_peering_required = true
}
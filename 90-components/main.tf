module "components" {
  for_each      = var.components
  source        = "git::https://github.com/maheshbabu22neeli/terraform-application-roboshop-components.git?ref=main"
  component     = each.key
  rule_priority = each.value.rule_priority
}
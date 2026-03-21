variable "components" {
  default = {
    # this will be used for backend alb listener rule
    catalogue = {
      rule_priority = 10
    }
    /*user = {
      rule_priority = 20
    }
    cart = {
      rule_priority = 30
    }
    shipping = {
      rule_priority = 40
    }
    payment = {
      rule_priority = 50
    }*/
    # this will be used for frontend alb listener rule
    frontend = {
      rule_priority = 10
    }
  }
}
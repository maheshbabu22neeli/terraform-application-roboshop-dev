// Bastion
resource "aws_security_group_rule" "bastion_internet" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  #cidr_blocks       = ["0.0.0.0/0"] # from internet
  cidr_blocks       = [local.my_ip]
  security_group_id = local.bastion_sg_id
}

// MongoDB
resource "aws_security_group_rule" "mongodb_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means mongodb accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type      = "ingress"
  from_port = 27017
  to_port   = 27017
  protocol  = "tcp"
  // which means mongodb accepting connection from catalogue
  source_security_group_id = local.catalogue_sg_id
  security_group_id        = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type      = "ingress"
  from_port = 27017
  to_port   = 27017
  protocol  = "tcp"
  // which means mongodb accepting connection from user
  source_security_group_id = local.user_sg_id
  security_group_id        = local.mongodb_sg_id
}


// Redis
resource "aws_security_group_rule" "redis_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means redis accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_user" {
  type      = "ingress"
  from_port = 6379
  to_port   = 6379
  protocol  = "tcp"
  // which means redis accepting connection from user
  source_security_group_id = local.user_sg_id
  security_group_id        = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  type      = "ingress"
  from_port = 6379
  to_port   = 6379
  protocol  = "tcp"
  // which means redis accepting connection from cart
  source_security_group_id = local.cart_sg_id
  security_group_id        = local.redis_sg_id
}


// MySQL
resource "aws_security_group_rule" "mysql_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means mysql accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.mysql_sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"
  // which means mysql accepting connection from shipping
  source_security_group_id = local.shipping_sg_id
  security_group_id        = local.mysql_sg_id
}


// RabbitMq
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means rabbitmq accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type      = "ingress"
  from_port = 5672
  to_port   = 5672
  protocol  = "tcp"
  // which means rabbitmq accepting connection from payment
  source_security_group_id = local.payment_sg_id
  security_group_id        = local.rabbitmq_sg_id
}


// Backend ALB
resource "aws_security_group_rule" "backend_alb_bastion" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // which means backend_alb accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_frontend" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // which means backend_alb accepting connection from frontend
  source_security_group_id = local.frontend_sg_id
  security_group_id        = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_catalogue" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // which means backend_alb accepting connection from catalogue
  source_security_group_id = local.catalogue_sg_id
  security_group_id        = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_user" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // which means backend_alb accepting connection from user
  source_security_group_id = local.user_sg_id
  security_group_id        = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_cart" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // which means backend_alb accepting connection from cart
  source_security_group_id = local.cart_sg_id
  security_group_id        = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_shipping" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // which means backend_alb accepting connection from shipping
  source_security_group_id = local.shipping_sg_id
  security_group_id        = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_payment" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  // which means backend_alb accepting connection from payment
  source_security_group_id = local.payment_sg_id
  security_group_id        = local.backend_alb_sg_id
}


// catalogue
resource "aws_security_group_rule" "catalogue_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means catalogue accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.catalogue_sg_id
}

resource "aws_security_group_rule" "catalogue_backend_alb" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  # which means catalogue accepting connection from backend_alb
  source_security_group_id = local.backend_alb_sg_id
  security_group_id        = local.catalogue_sg_id
}


// user
resource "aws_security_group_rule" "user_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means user accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.user_sg_id
}

resource "aws_security_group_rule" "user_backend_alb" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  # which means user accepting connection from backend_alb
  source_security_group_id = local.backend_alb_sg_id
  security_group_id        = local.user_sg_id
}


// cart
resource "aws_security_group_rule" "cart_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means cart accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.cart_sg_id
}

resource "aws_security_group_rule" "cart_backend_alb" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  # which means cart accepting connection from backend_alb
  source_security_group_id = local.backend_alb_sg_id
  security_group_id        = local.cart_sg_id
}


// shipping
resource "aws_security_group_rule" "shipping_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means shipping accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.shipping_sg_id
}

resource "aws_security_group_rule" "shipping_backend_alb" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  # which means shipping accepting connection from backend_alb
  source_security_group_id = local.backend_alb_sg_id
  security_group_id        = local.shipping_sg_id
}


// payment
resource "aws_security_group_rule" "payment_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means payment accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.payment_sg_id
}

resource "aws_security_group_rule" "payment_backend_alb" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  # which means payment accepting connection from backend_alb
  source_security_group_id = local.backend_alb_sg_id
  security_group_id        = local.payment_sg_id
}


# Frontend
resource "aws_security_group_rule" "frontend_bastion" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  // which means frontend accepting connection from bastion
  source_security_group_id = local.bastion_sg_id
  security_group_id        = local.frontend_sg_id
}

resource "aws_security_group_rule" "frontend_frontend_alb" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  # which means frontend accepting connection from backend_alb
  source_security_group_id = local.frontend_alb_sg_id
  security_group_id        = local.frontend_sg_id
}


# Frontend ALB
resource "aws_security_group_rule" "frontend_alb_internet" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  # Where traffic is coming from Internet / public
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.frontend_alb_sg_id
}

resource "aws_route53_record" "catalogue" {
  zone_id         = var.zone_id
  name            = "rabbitmq-${var.environment}.${var.domain_name}"
  type            = "A"
  ttl             = 1
  records         = [aws_instance.catalogue.private_ip]
  allow_overwrite = true
}
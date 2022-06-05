resource "aws_route53_zone" "private" {
  name = var.domain-name

  vpc {
    vpc_id = data.aws_vpc.vpc.id
  }
}


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = var.sub-domain-name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}




resource "aws_alb" "alb" {
  name            = "${var.name_prefix}-alb"
  internal        = "${var.internal}"
  security_groups = "${var.security_groups}"
  subnets         = "${var.subnets}"
  tags            = "${var.tags}"
}

resource "aws_route53_record" "webapp_ext_fqdn" {
  zone_id = "${var.route53zoneid}"
  name    = "${var.alb_name}"
  type    = "${var.route53type}"
  ttl     = "${var.route53ttl}"
  records = ["${aws_alb.alb.dns_name}"]
}

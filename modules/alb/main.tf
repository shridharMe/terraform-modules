resource "aws_alb" "alb" {
  name            = "${var.name}"
  internal        = "${var.internal}"
  security_groups = "${var.security_groups}"
  subnets         = "${var.subnets}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
    Terraform   = "${var.terraform}"
    Owner       = "${var.owner}"
  }
}

resource "aws_route53_record" "webapp_ext_fqdn" {
  zone_id = "${var.route53zoneid}"
  name    = "${aws_alb.alb.name}"
  type    = "${var.route53type}"
  ttl     = "${var.route53ttl}"
  records = ["${aws_alb.alb.dns_name}"]
}

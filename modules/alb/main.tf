resource "aws_alb" "alb" {
  name            = "${var.dns_name}"
  internal        = "${var.internal}"
  security_groups = ["${var.security_groups}"]
  subnets         = ["${var.subnets}"]

  tags {
    Name        = "${var.recordset_name}"
    Environment = "${var.environment}"
    Terraform   = "${var.terraform}"
    Owner       = "${var.owner}"
    Project     = "${var.project}"
  }
}

resource "aws_route53_record" "webapp_ext_fqdn" {
  zone_id = "${var.route53zoneid}"
  name    = "${var.recordset_name}"
  type    = "${var.route53type}"
  ttl     = "${var.route53ttl}"
  records = ["${aws_alb.alb.dns_name}"]
}

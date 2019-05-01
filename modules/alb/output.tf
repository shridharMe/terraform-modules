output "id" {
  value = "${aws_alb.alb.id}"
}

output "arn" {
  value = "${aws_alb.alb.arn}"
}

output "zone_id" {
  value = "${aws_alb.alb.zone_id}"
}

output "dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

output "fqdn" {
  value = "${aws_alb.alb.fqdn}"
}

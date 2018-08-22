output "ec2_instance_id" {
  value = "${aws_instance.ec2_instance.*.id}"
}

output "ec2_private_ip" {
  value = "${aws_instance.ec2_instance.*.private_ip}"
}

output "ec2_availability_zone" {
  value = "${aws_instance.ec2_instance.*.availability_zone}"
}

/*output "ec2_name" {
  value = "${aws_instance.ec2_instance.*.name}"
}*/

output "ec2_instance_cname" {
  value = "${aws_route53_record.ec2_instance_cname.*.fqdn}"
}

output "ec2_public_ip" {
  value = "${aws_instance.ec2_instance.*.public_ip}"
}

/* module for creating ec2 instance, use the interface.tf as the ref. for variables */

/* have a look here as a ref https://github.com/terraform-community-modules/tf_aws_ec2_instance and the terraform book */

resource "aws_instance" "ec2_instance" {
  ami = "${var.ami_id}"
  subnet_id = "${element(var.subnet_ids, 0)}"
  
  instance_type          = "${var.type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_groups}"]

  iam_instance_profile = "${var.iam_instance_profile}"

  user_data = "${var.user_data}"

  lifecycle {
    ignore_changes = ["user_data"]
  }

  root_block_device {
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
    delete_on_termination = "${var.delete_on_termination}"
  }

  tags {
    Terraform    = true
    Environment  = "${var.environment}"
    Name         = "${var.name}-0}"
    ResourceType = "${var.resource_type_tag}"

    //security monkey tags Service  and ServiceComponent
    Service          = "${var.service_tag}"
    ServiceComponent = "${var.servicecomponent_tag}"
    NetworkTier      = "${var.networktier_tag}"
  }
}

resource "aws_route53_record" "ec2_instance_cname" {

  zone_id = "${var.route53_zone_id}"
  name    = "${var.name}-0"
  type    = "A"
  ttl     = 60
  records = ["${element(aws_instance.ec2_instance.*.private_ip, 0)}"]
}

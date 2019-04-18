resource "aws_security_group_rule" "sg_rule}" {
  type                     = "${var.sg_type}"
  to_port                  = "${var.to_port}"
  protocol                 = "${var.protocol}"
  from_port                = "${var.from_port}"
  source_security_group_id = "${var.source_security_group_id}"
  security_group_id        = "${var.apply_on_security_group_id}"
}

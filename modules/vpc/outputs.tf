output "vpc_id" {
  value = "${aws_vpc.eks.id}"
}

output "cidr" {
  value = "${aws_vpc.eks.cidr_block}"
}

output "private_subnets" {
  value = "${aws_subnet.private.*.id}"
}

output "private_subnets_cidr" {
  value = "${aws_subnet.private.*.cidr_block}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "public_subnets_cidr" {
  value = "${aws_subnet.public.*.cidr_block}"
}

output "private_route_tables" {
  value = ["${aws_route_table.private.*.id}"]
}

output "public_route_tables" {
  value = ["${aws_route_table.public.*.id}"]
}

output "internet_gateway" {
  value = "${aws_internet_gateway.eks.id}"
}

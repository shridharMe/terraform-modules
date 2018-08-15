/* module for creating the VPC, use the interface.tf as the ref. for variables */

/* have a look here as a ref https://github.com/terraform-community-modules/tf_aws_vpc/blob/master/main.tf and the terraform book */

##The vpc to be created
resource "aws_vpc" "eks" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
    Terraform   = "${var.terraform}"
    Owner       = "${var.owner}"
  }
}

##internet gateway attached the vpc
resource "aws_internet_gateway" "eks" {
  vpc_id = "${aws_vpc.eks.id}"

  tags {
    Name = "${var.name}-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.eks.id}"
  count  = "${length(var.public_subnets)}"
  tags   = "${merge(var.tags, map("Name", format("%s-public-route-%s", var.name, element(var.azs, count.index))))}"
}

# add a public gateway to each public route table
resource "aws_route" "public_gateway_route" {
  count                  = "${length(var.public_subnets)}"
  route_table_id         = "${element(aws_route_table.public.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.eks.id}"
}

# Attach a nat gateway to each private subnet for internet access
resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
  count                  = "${length(var.private_subnets)}"
}

##creates the private subnets for the vpc, iterates through the var.private_subnets map
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.eks.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.private_subnets)}"

  #tags              = "${merge(var.tags, map("Name", format("%s-private-%s", var.name, element(var.azs, count.index))))}"
  tags {
    Name        = "${format("%s-private-%s", var.name, element(var.azs, count.index))}"
    Environment = "${var.environment}"
    Terraform   = "${var.terraform}"
    Owner       = "${var.owner}"
  }
}

##creates the private subnets for the vpc, iterates through the var.public_subnets map
resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.eks.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.public_subnets)}"

  #tags              = "${merge(var.tags, map("Name", format("%s-public-%s", var.name, element(var.azs, count.index))))}"

  tags {
    Name        = "${format("%s-public-%s", var.name, element(var.azs, count.index))}"
    Environment = "${var.environment}"
    Terraform   = "${var.terraform}"
    Owner       = "${var.owner}"
  }
}

##each NAT instance need an elastic IP
resource "aws_eip" "natip" {
  vpc   = true
  count = "${length(var.public_subnets)}"
}

#creates a nat gateway for each private subnet in each public subnet for redundency
# 
resource "aws_nat_gateway" "natgw" {
  allocation_id = "${(element(aws_eip.natip.*.id, count.index))}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  count         = "${length(var.public_subnets)}"

  ##make sure the gateway is in place before creating the nats
  depends_on = ["aws_internet_gateway.eks"]
}

# Creates a route table for each private subnet
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.eks.id}"
  count  = "${length(var.private_subnets)}"

  tags = "${merge(var.tags, map("Name", format("%s-private-route-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = "${aws_vpc.eks.id}"
  route_table_id = "${aws_route_table.private.0.id}"
}

data "aws_vpc" "selected_vpc" {
  id = "${var.vpc_id}"
  default = "${var.vpc_id == "" ? true : false}"
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = "${data.aws_vpc.selected_vpc.id}"
}

resource "random_shuffle" "subnets" {
  input = [
    "${data.aws_subnet_ids.subnet_ids.ids}"
  ]
}

data "aws_subnet" "subnet_selected" {
  id = "${var.subnet_id == "" ? random_shuffle.subnets.result.0 : var.subnet_id}"
  vpc_id = "${data.aws_vpc.selected_vpc.id}"
}

resource "aws_security_group" "nginx" {
  name = "${var.stackname}"
  description = "sg for stack ${var.stackname}"
  vpc_id = "${data.aws_vpc.selected_vpc.id}"
}

resource "aws_security_group_rule" "allow_all_traffic_inside_vpc" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.nginx.id}"
  to_port = 0
  type = "ingress"
  cidr_blocks = [
    "${data.aws_vpc.selected_vpc.cidr_block}"
  ]
}

resource "aws_security_group_rule" "allow_all_traffic_inside_sg" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.nginx.id}"
  to_port = 0
  type = "ingress"
  self = true
}

resource "aws_security_group_rule" "allow_http" {
  from_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.nginx.id}"
  to_port = 80
  type = "ingress"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "allow_sf_8585" {
  from_port = 8585
  protocol = "tcp"
  security_group_id = "${aws_security_group.nginx.id}"
  to_port = 8585
  type = "ingress"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "allow_https" {
  from_port = 443
  protocol = "tcp"
  security_group_id = "${aws_security_group.nginx.id}"
  to_port = 443
  type = "ingress"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "allow_ssh" {
  from_port = 22
  protocol = "tcp"
  security_group_id = "${aws_security_group.nginx.id}"
  to_port = 22
  type = "ingress"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}

resource "aws_security_group_rule" "allow_all_outbound" {
  from_port = 0
  protocol = "-1"
  security_group_id = "${aws_security_group.nginx.id}"
  to_port = 0
  type = "egress"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}
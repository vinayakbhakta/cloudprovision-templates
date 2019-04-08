resource "aws_instance" "nginx" {
  count = "${var.num_nodes}"
  ami = "${var.os_type == "ubuntu1604" ? data.aws_ami.ubuntu1604.id : data.aws_ami.centos7.id}"
  instance_type = "${var.node_instance_type}"
  key_name = "${var.ssh_key_name}"
  associate_public_ip_address = true
  tags {
    Name = "nginx-${count.index}"
    Stack = "${var.stackname}"
  }
  root_block_device {
    volume_type = "${var.node_disk_type}"
    volume_size = "${var.node_disk_size}"
    delete_on_termination = true
  }
  subnet_id = "${data.aws_subnet.subnet_selected.id}"
  vpc_security_group_ids = [
    "${aws_security_group.nginx.id}"
  ]
  availability_zone = "${data.aws_subnet.subnet_selected.availability_zone}"
}

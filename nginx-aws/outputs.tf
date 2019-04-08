output "nodes" {
  value = "${aws_instance.nginx.*.public_ip}"
}



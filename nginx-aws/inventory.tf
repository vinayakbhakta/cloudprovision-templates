/*
* Create Inventory File
*/

data "template_file" "nginx-nodes" {
  count = "${var.num_nodes}"
  template = "${file("${path.module}/templates/node.tpl")}"
  vars {
    name = "${element(aws_instance.nginx.*.tags.Name, count.index)}"
    public = "${element(aws_instance.nginx.*.public_ip, count.index)}"
    private = "${element(aws_instance.nginx.*.private_ip, count.index)}"
  }
}

data "template_file" "inventory_data" {
  template = "${file("${path.module}/templates/inventory.tpl")}"

  vars {
    connection_strings_nodes = "${join("\n",data.template_file.nginx-nodes.*.rendered)}"
    list_nodes = "${join("\n",aws_instance.nginx.*.tags.Name)}"
  }
}

resource "null_resource" "inventory_file" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory_data.rendered}' > ${path.cwd}/hosts.ini"
  }

  triggers {
    template = "${data.template_file.inventory_data.rendered}"
  }
}

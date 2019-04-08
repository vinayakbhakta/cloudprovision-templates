resource "null_resource" "keypermisions" {
  provisioner "local-exec" {
    command = "chmod 400 ${var.ssh_key_path}/*"
  }
}

resource "null_resource" "run-ansible" {
  depends_on = [
    "null_resource.inventory_file"
  ]
  provisioner "local-exec" {
    command = "cd ${path.module}/ansible && export ANSIBLE_CONFIG=${path.module}/ansible/ansible.cfg && ansible-playbook -vvvv -b --user=${var.ssh_user} -i ${path.module}/hosts.ini --key-file=${path.module}/${var.ssh_key_path}/${var.ssh_key_name}.pem ${path.module}/ansible/playbook.yml"
  }
}

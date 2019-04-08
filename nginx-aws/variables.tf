variable "region" {}

variable "access_key" {}

variable "secret_key" {}

variable "session_token" {
  default = ""
}

variable "stackname" {}

variable "appname" {}

variable "vpc_id" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "os_type" {
  default = "centos7"
}

variable "num_nodes" {
  default = 1
}

variable "node_instance_type" {
  default = "t2.large"
}

variable "node_disk_type" {
  default = "standard"
}

variable "node_disk_size" {
  default = 20
}

variable "ssh_user" {
  default = "centos"
}

variable "ssh_key_path" {
  default = "keys"
}

variable "ssh_key_name" {
  default = "shared-SSHkey-fordemo"
}
provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  token = "${var.session_token}"
}

data "aws_ami" "ubuntu1604" {
  most_recent = true
  owners = [
    "099720109477"]
  # Canonical

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  filter {
    name = "architecture"
    values = [
      "x86_64"]
  }

  filter {
    name = "root-device-type"
    values = [
      "ebs"]
  }
}

data "aws_ami" "centos7" {
  most_recent = true
  owners = [
    "679593333241"]
  # CentOS

  filter {
    name = "name"
    values = [
      "CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  filter {
    name = "architecture"
    values = [
      "x86_64"]
  }

  filter {
    name = "root-device-type"
    values = [
      "ebs"]
  }
}

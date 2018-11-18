variable "region" {}

variable "instance_type" {}

variable "environment" {}

variable "access_ip" {}

locals {
  dnsname = "${var.environment}.test.mobi"
}

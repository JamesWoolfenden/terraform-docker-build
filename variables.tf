variable "region" {}

variable "instance_type" {}

variable "environment" {}

variable "aws_amis" {
  description = "These are ubuntu 14.04 ami"

  default = {
    us-east-1 = "ami-d05e75b8"
    eu-west-1 = "ami-47a23a30"
  }
}

variable "access_ip" {}

locals {
  dnsname = "${var.environment}.test.mobi"
}

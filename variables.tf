variable "region" {
    default = "eu-west-1"
}

variable "instance_type" {
   default="m4.large"
}

variable "environment" {
  default="development"
}


variable "aws_amis" {
    description="These are ubuntu 14.04 ami"
    default = {
      us-east-1="ami-d05e75b8"
      eu-west-1="ami-47a23a30"
    }
}

variable "access_ip" {}

locals {
  dnsname="${var.environment}.test.mobi"
}
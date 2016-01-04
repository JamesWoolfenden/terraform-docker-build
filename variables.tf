variable "access_key" {
  description  ="AWS access key"
}

variable "secret_key" {
  description  ="AWS secret"
}

variable "s3_access_key" {
  description  ="TF_VAR_s3_access_key"
}

variable "s3_secret_key" {
  description  ="TF_VAR_s3_secret_key"
}

variable "key_path" {
   description  ="path to key for ssh"
   default="C:\Users\James\.ssh\cassandra"
}

variable "git_hub_key" {
   description  ="path to key for ssh"
   default="~/.ssh/github"
}

variable "region" {
    default = "eu-west-1"
}

variable "instance_type" {
   default="m4.large"
}

variable "environment" {
  default="development"
}

variable "domain" {
  default ="aevi-test.io"
}

variable "branchname" {
  #deafult="develop"
  default ="fix-demo-dataloader"
}

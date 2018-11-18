data "aws_ami" "ubuntu" {
  most_recent      = true
  executable_users = ["self"]

  filter {
    name   = "name"
    values = ["ubuntu*"]
  }

  owners = ["self"]
}

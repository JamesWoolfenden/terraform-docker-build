resource "aws_key_pair" "docker-compose" {
  key_name   = "docker-compose-${var.environment}"
  public_key = "${tls_private_key.key.public_key_openssh}"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

#
# Launch Container Instance
#

resource "aws_instance" "docker-host" {
    availability_zone    = "${var.region}c"
    key_name             = "${aws_key_pair.docker-compose.key_name}"
    ami                  = "${lookup(var.aws_amis, var.region)}"
    instance_type        = "${var.instance_type}"

    root_block_device {
      volume_type = "standard"
      volume_size = 100
      delete_on_termination = 1
    }

    provisioner "file" {
       source = "${var.key_path}"
       destination = "${var.git_hub_key}"
       connection {
          user = "ubuntu"
          key_file="${var.key_path}"}
       }

    provisioner "file" {
       source = "script.sh"
       destination = "/tmp/script.sh"
       connection {
                  user = "ubuntu"
                  key_file="${var.key_path}"}
       }

    #dependencies and build
    provisioner "remote-exec" {
       inline = [
          "echo 'export AWS_ACCESS_KEY_ID_RELEASES_AEVI_COM=${var.s3_access_key}' >> ~/.bashrc",
          "echo 'export AWS_SECRET_KEY_RELEASES_AEVI_COM=${var.s3_secret_key}' >> ~/.bashrc",
          "echo 'export AWS_ACCESS_KEY_ID=${var.s3_access_key}' >> ~/.bashrc",
          "echo 'export AWS_SECRET_ACCESS_KEY=${var.s3_secret_key}' >> ~/.bashrc",
          "echo 'export DB_HOST1_PORT_9042_TCP_ADDR=${aws_instance.docker-host.public_dns}' >> ~/.bashrc",
          "echo 'export DNSNAME=${var.environment}.${var.domain}' >> ~/.bashrc",
          "chmod +x /tmp/script.sh",
          "chmod 400 ${var.git_hub_key}",
          "ssh-keyscan github.com >> ~/.ssh/known_hosts",
          "ssh-add ${var.git_hub_key}",
          "echo 'IdentityFile ${var.git_hub_key}' > ~/.ssh/config",
          "/tmp/script.sh args"
          ]
          connection {
               user = "ubuntu"
               key_file="${var.key_path}"}
    }

    #new login should refresh docker group, stands up docker containers
    provisioner "remote-exec" {
       inline = [
          "cd Aevi-EcoSystem",
          "sh buildDockerImage.sh",
          "nohup docker-compose up &"
          ]
          connection {
               user = "ubuntu"
               key_file="${var.key_path}"}
    }

    provisioner "local-exec" {
        command = "echo config: > hosts\${aws_instance.docker-host.public_ip}"
    }
    provisioner "local-exec" {
        command = "echo public_ip= ${aws_instance.docker-host.public_ip} >> hosts\${aws_instance.docker-host.public_ip}"
    }
    provisioner "local-exec" {
        command = "echo private_ip= ${aws_instance.docker-host.private_ip} >> hosts\${aws_instance.docker-host.public_ip}"
    }

    tags  = {
        "Name"        = "docker-compose-${var.environment}"
        "Environment" = "${var.environment}"
    }

    security_groups=["${aws_security_group.docker-compose.name}"]
}

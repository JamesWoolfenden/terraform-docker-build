#
# Launch Container host
#

resource "aws_instance" "docker-host" {
  #checkov:skip=CKV_AWS_46: "Ensure no hard coded AWS access key and secret key exists in EC2 user data"
  availability_zone = "${var.region}c"
  key_name          = aws_key_pair.docker-compose.key_name
  ami               = data.aws_ami.ubuntu.image_id
  instance_type     = var.instance_type

  root_block_device {
    encrypted             = true
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = true
  }

  metadata_options {
    http_tokens = "required"
  }
  user_data = <<EOT
sudo apt-get update
sudo apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-get -y install python-pip
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo add-apt-repository ppa:webupd8team/java -y
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer

#this get the latest docker t00ls
echo "Installing the latest docker"
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker ubuntu
source ~/.bash_profile
sudo pip install -U docker-compose

#add node and bower
echo "Installing the latest node"
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm update -g npm
sudo npm install -g grunt-cli
sudo npm install -g bower

#sbt
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get -y install sbt

sudo apt-get -y install oracle-java8-set-default

#typesafe-activator
sudo wget downloads.typesafe.com/typesafe-activator/1.3.6/typesafe-activator-1.3.6.zip
sudo apt-get install unzip
unzip typesafe-activator-1.3.6.zip
sudo ln -s /home/ubuntu/activator-1.3.6/activator /usr/bin/activator

#built not bring em online
nohup docker-compose up &
EOT

  tags = {
    "Name"        = "docker-compose-${var.environment}"
    "Environment" = var.environment
  }

  security_groups = [aws_security_group.docker-compose.name]
}

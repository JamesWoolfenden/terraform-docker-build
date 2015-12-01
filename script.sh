#!/bin/sh
#basic stuff
sudo apt-get update
sudo apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#sudo vim /etc/apt/sources.list.d/docker.list
#sudo apt-get update
#sudo apt-get -y upgrade
sudo apt-get -y install python-pip
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo add-apt-repository ppa:webupd8team/java -y
#sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer
#sudo apt-get -y install openjdk-8-jdk

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
#./activator clean stage
git clone git@github.com:Wincor-Nixdorf/Aevi-EcoSystem.git
sudo apt-get -y install oracle-java8-set-default
#typesafe-activator
sudo wget downloads.typesafe.com/typesafe-activator/1.3.6/typesafe-activator-1.3.6.zip
sudo apt-get install unzip
unzip typesafe-activator-1.3.6.zip
sudo ln -s /home/ubuntu/activator-1.3.6/activator /usr/bin/activator
#and builds
cd Aevi-EcoSystem
sh buildDockerImage.sh
#built not bring em online
nohup docker-compose up &
#needs data
sh runDemoDataLoader.sh

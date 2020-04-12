#!/bin/bash



sudo yum -y update
sudo yum -y install yum-utils device-mapper-persistent-data lvm2
sudo sh -c 'echo vm.max_map_count=262144 >> /etc/sysctl.d/99-sysctl.conf'
sudo sed -i -e "s/^SELINUX=enforcing$/SELINUX=disabled/g" /etc/selinux/config

# https://docs.docker.com/install/linux/docker-ce/centos/
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker

sudo groupadd docker
sudo gpasswd -a $USER docker

sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod og+x /usr/local/bin/docker-compose
sudo chgrp docker /usr/local/bin/docker-compose

sudo yum -y install git
git clone https://github.com/RCOSDP/weko.git
cd weko
git checkout origin/develop
sudo reboot



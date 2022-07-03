#!/bin/sh
echo "set -o vi" >> /home/ec2-user/.bashrc

# install packages
yum update -y
yum install -y \
  git \
  docker

# setup docker
sudo usermod -a -G docker ec2-user
sudo pip3 install docker-compose
sudo systemctl enable docker.service
sudo systemctl start docker.service

# run docker jenkins
git clone https://github.com/rivera-bl/jenkins-casc /home/ec2-user/jenkins-casc
cd /home/ec2-user/jenkins-casc
docker build -t jenkins-as-code:test .
docker-compose up -d

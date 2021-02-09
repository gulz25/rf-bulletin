#!/bin/bash

## centos 7
yum -y update
localectl set-locale en_US.UTF-8
source /etc/locale.conf
if [ $(uname -n) = "rf-jumphost" ]; then
    echo "this is jumphost" > introduction.md
elif [ $(uname -n) = "rf-osclass" ]; then
    yum -y install traceroute git docker docker-compose composer
    systemctl start docker
    systemctl enable docker
    mkdir /mnt/osclass /mnt/mariadb_data
    curl -sSL https://raw.githubusercontent.com/gulz25/rf-bulletin/main/scripts/docker-compose.yml > /root/docker-compose.yml
    docker-compose up -d

#!/bin/bash

## centos 7
yum -y update
if [ $(uname -n) = "rf-jumphost" ]; then
    echo "this is jumphost" > introduction.md
elif [ $(uname -n) = "rf-web" ]; then
    yum -y install docker docker-compose epel-release
    yum -y install snapd
    systemctl enable --now  docker snapd.socket
    groupadd docker
    usermod -aG docker maeseiji
    mkdir -p docker/mysql docker/nginx/conf.d/ docker/wordpress
    cd docker
    curl -sSL https://raw.githubusercontent.com/gulz25/rf-bulletin/main/scripts/docker-compose.yml > /home/maeseiji/docker/docker-compose.yml
    curl -sSL https://raw.githubusercontent.com/gulz25/rf-bulletin/main/scripts/Docker > /home/maeseiji/docker/Dockerfile
    curl -sSL https://raw.githubusercontent.com/gulz25/rf-bulletin/main/scripts/.env > /home/maeseiji/docker/.env
    curl -sSL https://raw.githubusercontent.com/gulz25/rf-bulletin/main/scripts/nginx/nginx.conf > /home/maeseiji/docker/nginx/nginx.conf
    curl -sSL https://raw.githubusercontent.com/gulz25/rf-bulletin/main/scripts/nginx/conf.d/default.conf > /home/maeseiji/docker/nginx/conf.d/default.conf
    docker-compose up -d
    sleep 10
    snap install core; snap refresh core
    ln -s /var/lib/snapd/snap /snap
    snap install --classic certbot
    ln -s /snap/bin/certbot /usr/bin/certbot
    # certbot --nginx
    # certbot renew --dry-run
fi

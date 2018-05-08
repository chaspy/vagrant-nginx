#!/bin/bash
cp /vagrant/nginx.repo /etc/yum.repos.d/
yum update -y
yum install -y nginx
cp -f /vagrant/nginx.conf /etc/nginx/
mkdir -p /var/www/html
cp /vagrant/index.html /var/www/html/
systemctl start nginx.service

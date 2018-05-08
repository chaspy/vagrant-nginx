#!/bin/bash
cp /vagrant/nginx.repo /etc/yum.repos.d/
yum update -y
yum install -y nginx
nginx

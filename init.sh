#!/bin/bash
VERSION=1.14.0

yum update -y
yum install -y git
yum install -y gcc
yum install -y pcre-devel openssl-devel libxslt-devel gd-devel perl-ExtUtils-Embed epel-release
yum install -y GeoIP-devel
yum install -y lua-devel

cd /usr/local/src/
# for ngx_lua
git clone https://github.com/openresty/lua-nginx-module.git
git clone https://github.com/simpl/ngx_devel_kit.git

curl -L -O http://nginx.org/download/nginx-$VERSION.tar.gz
tar zxvf ./nginx-$VERSION.tar.gz
cd nginx-$VERSION
./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/nginx --add-module=/usr/local/src/lua-nginx-module --add-module=/usr/local/src/ngx_devel_kit
make
sudo make install
echo "export PATH=/usr/local/nginx/:$PATH" >> /etc/profile.d/nginx.sh
source /etc/profile

cp -f /vagrant/nginx.conf /usr/local/nginx/conf/
mkdir -p /var/www/html
mkdir -p /var/log/nginx
cp /vagrant/*.html /var/www/html/

touch /var/log/nginx/www.example.com_access.log
touch /var/log/nginx/www.example.com_error.log

nginx

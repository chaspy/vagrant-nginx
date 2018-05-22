#!/bin/bash
VERSION=1.14.0
NGINX_SRC=/usr/local/src/nginx-$VERSION
NGX_MRUBY_SRC=/usr/local/src/ngx_mruby

yum update -y
yum install -y git
yum install -y gcc
yum install -y pcre-devel openssl-devel libxslt-devel gd-devel perl-ExtUtils-Embed epel-release
yum install -y GeoIP-devel
yum install -y lua-devel
yum install -y ruby bison rake

# get sources
cd /usr/local/src/
git clone https://github.com/openresty/lua-nginx-module.git
git clone https://github.com/simpl/ngx_devel_kit.git
git clone https://github.com/matsumoto-r/ngx_mruby.git
curl -L -O http://nginx.org/download/nginx-$VERSION.tar.gz
tar zxvf ./nginx-$VERSION.tar.gz

# nginx_mruby
cd ${NGX_MRUBY_SRC}
git submodule init
git submodule update
./configure --with-ngx-src-root=${NGINX_SRC}
make build_mruby
make generate_gems_config

# nginx
cd $NGINX_SRC
./configure --prefix=/usr/local/nginx --sbin-path=/usr/local/nginx --add-module=/usr/local/src/lua-nginx-module --add-module=/usr/local/src/ngx_devel_kit --add-module=${NGX_MRUBY_SRC}
make
sudo make install

echo "export PATH=/usr/local/nginx/:$PATH" >> /etc/profile.d/nginx.sh
source /etc/profile

cp -f /vagrant/nginx.conf /usr/local/nginx/conf/
cp -f /vagrant/fizzbuzz.rb /usr/local/nginx/conf/
mkdir -p /var/www/html
mkdir -p /var/log/nginx
cp /vagrant/*.html /var/www/html/

touch /var/log/nginx/www.example.com_access.log
touch /var/log/nginx/www.example.com_error.log

nginx

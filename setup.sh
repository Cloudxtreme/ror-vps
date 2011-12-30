#!/bin/bash

#This script needs of chmod +wx


#Definitions

RUBY_VERSION="ruby-1.9.3-p0"
NGINX_VERSION="nginx-1.0.11"

#Variables

green="\033[01;32m"
blue="\033[01;34m"
red="\033[01;31m"
end_color="\033[00m"

#functions

function system_update {
	apt-get update
	apt-get -y install aptitude
	aptitude -y install build-essential zlib1g-dev libssl-dev libreadline5-dev openssh-server libyaml-dev libcurl4-openssl-dev libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev libsqlite3

}

function ruby_install {
  cd /tmp
  wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/$RUBY_VERSION.tar.gz
  tar xzf $RUBY_VERSION.tar.gz
  rm "$RUBY_VERSION.tar.gz"
  cd $RUBY_VERSION
  ./configure
  make
  make install
  cd ..
  rm -rf $RUBY_VERSION
}

function passenger_install {
  gem install passenger --no-ri --no-rdoc
}

function nginx_download {
  rm -Rf /tmp/$NGINX_VERSION
  cd /tmp
  wget http://nginx.org/download/$NGINX_VERSION.tar.gz
  tar xzf $NGINX_VERSION.tar.gz
  rm "$NGINX_VERSION.tar.gz"
}

function module_up_download {
  rm -Rf /tmp/up
  cd /tmp
  git clone git://github.com/masterzen/nginx-upload-progress-module.git
  mv nginx-upload-progress-module/ up/
}

function nginx_install_with_passenger_module {
  rvmsudo passenger-install-nginx-module --auto --nginx-source-dir=/tmp/$NGINX_VERSION --prefix=/opt/nginx --extra-configure-flags="--add-module=/tmp/up"
}

#Running
echo "-------------------------------------------------------------------------------"
echo -e $green "Starting..." $end_color
echo
echo -e $green "Updating the system..." $end_color
echo
system_update
echo
echo -e $green "Downloading o nginx..." $end_color
echo
nginx_download
echo
echo -e $green "Downloading the module \"upload-progress for nginx\"..." $end_color
echo
module_up_download
echo
echo -e $green "Downloading and Instaling the passenger with nginx..." $end_color
echo
nginx_install_with_passenger_module
echo
echo "==============================================================================="
echo -e $blue "Pronto!" $end_color
echo "==============================================================================="

#!/bin/bash

#This script needs of chmod +wx


#Definitions

RUBY_VERSION="ruby-1.9.3-p0"
NGINX_VERSION="nginx-1.0.11"
# RUBY_VERSION="ruby-1.9.3-p194"
# NGINX_VERSION="nginx-1.3.3"

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
  sudo gem install passenger --no-ri --no-rdoc
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
  sudo passenger-install-nginx-module --auto --nginx-source-dir=/tmp/$NGINX_VERSION --prefix=/opt/nginx --extra-configure-flags="--add-module=/tmp/up"
}

#Running
echo "-------------------------------------------------------------------------------"
echo -e $blue "Starting..." $end_color
echo
sleep 1
echo -e $blue "Preparing update the system..." $end_color
echo
sleep 1
system_update
echo
echo -e $green "Updated system..." $end_color
echo
sleep 1
echo
echo -e $blue "Preparing to install Ruby" $end_color
echo
sleep 1
echo
echo -e $blue "Instaling $RUBY_VERSION" $end_color
echo
sleep 1
ruby_install
echo
echo -e $green "$RUBY_VERSION installed with success" $end_color
echo
sleep 1
echo
echo -e $blue "Preparing to download NGINX" $end_color
echo
sleep 1
echo
echo -e $blue "Downloading o nginx..." $end_color
echo
nginx_download
echo
sleep 1
echo
echo -e $blue "Downloading the module \"upload-progress for nginx\"..." $end_color
echo
module_up_download
echo
sleep 1
echo -e $green "Downloading and Instaling the passenger with nginx..." $end_color
echo
nginx_install_with_passenger_module
echo
sleep 1
echo -e $green "===========================================================================" $end_color
echo -e $green "Pronto!" $end_color
echo -e $green "===========================================================================" $end_color
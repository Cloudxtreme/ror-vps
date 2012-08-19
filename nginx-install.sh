#!/bin/bash

#This script needs of chmod +wx

#Definitions

NGINX_VERSION="nginx-1.0.11"

#Variables

green="\033[01;32m"
blue="\033[01;34m"
red="\033[01;31m"
end_color="\033[00m"

#functions

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
echo -e $green "Starting..." $end_color
echo
#passenger_install
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

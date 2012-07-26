#!/bin/bash

#This script needs of chmod +wx

RUBY_VERSION="ruby-1.9.3-p194"

#Variables

green="\033[01;32m"
blue="\033[01;34m"
red="\033[01;31m"
end_color="\033[00m"

#functions

function system_update() {
	apt-get update
	apt-get -y install aptitude
	aptitude -y install build-essential zlib1g-dev libssl-dev libreadline5-dev openssh-server libyaml-dev libcurl4-openssl-dev libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev libsqlite3
}

function ruby_install() {
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

#Running
echo "-------------------------------------------------------------------------------"
echo -e $green "Starting..." $end_color
echo
echo -e $green "Updating the system..." $end_color
echo
system_update();
echo
echo -e $green "Instaling $RUBY_VERSION" $end_color
echo
ruby_install();
echo
echo "==============================================================================="
echo -e $blue "Pronto!" $end_color
echo "==============================================================================="
#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt update
apt upgrade -y
apt install -y python3 python3-pip
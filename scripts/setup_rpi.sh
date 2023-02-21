#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Install linux stuff
# apt update
# apt upgrade -y
# apt install -y python3 python3-pip nginx htop curl wget

# Install python libs
pip3 install RPi.GPIO
pip3 install flask

# NVM
touch ~/.bashrc
su - admin -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash"
source ~/.bashrc
nvm install 16
nvm install 18

# build frontend
cd frontend
nvm use
npm install
npm run build
cd ..

pwd
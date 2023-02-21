#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Install linux stuff
echo "Updating linux packages..."
# apt update
# apt upgrade -y
echo "Installing required linux packages..."
# apt install -y python3 python3-pip nginx htop curl wget

# Install python libs
echo "Installing python libraries..."
pip3 install RPi.GPIO
pip3 install flask
pip3 install gunicorn

# NVM
echo "Installing NVM and NodeJS..."
touch ~/.bashrc
su - admin -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash"
. ~/.bashrc
nvm install 16
nvm install 18

# build frontend
echo "Building frontend application..."
cd frontend
nvm use
npm install
npm run build
cd ..

# deploy front and backend
echo "Deploying frontend and backend..."
sudo bash scripts/local_deploy.sh

# done
echo "Smart Terrarium setup COMPLETED!"
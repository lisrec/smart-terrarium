#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

pwd

echo "Coping files..."
mkdir -p /var/smart-terrarium/api
mkdir -p /var/smart-terrarium/www

cp -r ./backend/* /var/smart-terrarium/api
cp -r ./frontend/dist/* /var/smart-terrarium/www

echo "Setting directory owners..."
chgrp -R www-data /var/smart-terrarium/www
chown -R admin:www-data /var/smart-terrarium/api
chmod 755 /var/smart-terrarium/api
chmod 755 /var/smart-terrarium/www

echo "Configure gunicorn service..."
systemctl stop smart-terrarium
systemctl disable smart-terrarium
cp ./configs/smart-terrarium.service /etc/systemd/system/smart-terrarium.service
systemctl enable smart-terrarium
systemctl start smart-terrarium

echo "Configure nginx service..."
rm /etc/nginx/sites-enabled/default
cp ./configs/nginx.conf /etc/nginx/sites-available/smart-terrarium.conf
ln -s /etc/nginx/sites-available/smart-terrarium.conf /etc/nginx/sites-enabled/
systemctl restart nginx
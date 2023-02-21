#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Coping files..."
mkdir -p /var/smart-terrarium/www
cp -r ./frontend/dist/* /var/smart-terrarium/www

echo "Setting directory owners..."
chgrp -R www-data /var/smart-terrarium/www
chmod 755 /var/smart-terrarium/www

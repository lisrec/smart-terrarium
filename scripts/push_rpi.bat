@echo off

:: Create working directories on RPi home
mkdir Z:\smart-terrarium-temp
mkdir Z:\smart-terrarium-temp\api
mkdir Z:\smart-terrarium-temp\www
mkdir Z:\smart-terrarium-temp\configs

:: Copy backend python files to RPi
robocopy ..\backend Z:\smart-terrarium-temp\api /s /e

:: Copy built frontend to RPi nginx directory 
robocopy ..\frontend\dist Z:\smart-terrarium-temp\www /s /e

:: Copy nginx config
copy ..\configs\nginx.conf Z:\smart-terrarium-temp\configs\smart-terrarium

:: Copy systemctrl file
copy ..\configs\systemmd-app.service Z:\smart-terrarium-temp\configs\smart-terrarium.service

:: Copy script to be localy run on RPi
copy .\local_deploy.sh Z:\smart-terrarium-temp\local_deploy.sh
copy .\bump_front.sh Z:\smart-terrarium-temp\bump_front.sh
copy .\bump_backend.sh Z:\smart-terrarium-temp\bump_backend.sh

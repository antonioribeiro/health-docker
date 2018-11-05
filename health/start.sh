#!/bin/bash

##
 # make storage directories
 #
mkdir -p ./storage/logs
mkdir -p ./storage/app/public
mkdir -p ./storage/framework/cache
mkdir -p ./storage/framework/views
mkdir -p ./storage/framework/testing
mkdir -p ./storage/framework/sessions

##
 # endless loop
 #
php artisan migrate:fresh


##
 # start nginx
 #
echo "Starting nginx..."
/etc/init.d/nginx start

##
 # start php-fpm
 #
echo "Starting PHP-FPM..."
/etc/init.d/php7.2-fpm start

##
 # endless loop
 #
echo "Press [CTRL+C] to stop.."
while :
do
	sleep 1
done

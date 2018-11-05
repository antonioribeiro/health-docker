#!/bin/bash
set -eux  # https://sipb.mit.edu/doc/safe-shell/

##
 # configure git
 #
sudo -u nginx /usr/bin/git config --global user.email "${GIT_USER_EMAIL}"
sudo -u nginx /usr/bin/git config --global user.name "${GIT_USER_NAME}"


##
 # make sure storage directories exists
 #
mkdir -p /health/repository/storage/logs
mkdir -p /health/repository/storage/app/public
mkdir -p /health/repository/storage/framework/cache
mkdir -p /health/repository/storage/framework/views
mkdir -p /health/repository/storage/framework/testing
mkdir -p /health/repository/storage/framework/sessions
chown nginx:nginx -R /health/repository/storage


##
 # wait for the MySQL server to be ready
 #
/health/wait-for-it.sh --strict --timeout=60 --host=mysql --port=3306 -- echo "The MySQL server is ready"
if [[ $? -ne 0 ]]; then
	echo "Error while waiting for the MySQL server !"
	exit 1
fi

##
 # setup database
 #
sudo -u nginx php artisan migrate:fresh


##
 # start nginx
 #
echo "Starting nginx..."
exec /start.sh
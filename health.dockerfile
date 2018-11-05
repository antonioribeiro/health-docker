##
 # image
 #
FROM wyveo/nginx-php-fpm:latest

##
 # MAINTAINER
 #
LABEL maintainer="Antonio Carlos Ribeiro <acr@antoniocarlosribeiro.com>"

##
 # variables
 #
ARG health_path=/health
ARG root_home=/root
ARG app_path=$health_path/repository
ARG git_repository=https://github.com/laravel/laravel.git
ARG git_bin=/usr/bin/git
ARG composer_path=/usr/local/bin
ARG email="health@health.io"
ARG name="health"

##
# configure NGINX
#
ADD ./etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

##
 # environment
 #
ENV APP_DIR=$app_path
ENV APP_WORKERS=1
ENV PHP_BIN=/usr/local/bin/php
ENV GIT_BIN=$git_bin
ENV COMPOSER_BIN=$composer_path/composer
ENV COMPOSER_ALLOW_SUPERUSER=1

##
 # app starter scripts
 #
COPY .$health_path/start.sh $health_path/start.sh

##
 # add aliases
 #
COPY .$root_home/.bashrc $root_home/.bashrc

##
# install PHP stuff
#
RUN apt-get update \
  && apt-get install --yes mysql-client sudo git joe locales telnet unzip zip procps \
     zlib1g-dev php-zip php-mysql --no-install-recommends

##
 # configure git
 #
RUN $git_bin config --global user.email "$email" \
  && $git_bin config --global user.name "$name"

##
 # clone repository
 #
RUN git clone $git_repository $app_path

##
# Set the workdir
#
WORKDIR $app_path

##
# Install stuff
#

RUN composer install  
RUN composer require pragmarx/health  
RUN php artisan vendor:publish --provider="PragmaRX\\Health\\ServiceProvider"

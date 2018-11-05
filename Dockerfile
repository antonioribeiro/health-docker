##
 # image
 #
FROM wyveo/nginx-php-fpm:php72

##
 # MAINTAINER
 #
LABEL maintainer="Antonio Carlos Ribeiro <acr@antoniocarlosribeiro.com>"

##
 # build time variables
 #
ARG LARAVEL_TAG=v5.6.12
ARG LARAVEL_HEALTH_VERSION=dev-master


##
# install PHP stuff
#
RUN apt-get update \
  && apt-get install --yes mysql-client sudo git joe locales telnet unzip zip procps \
     zlib1g-dev php-zip php-mysql --no-install-recommends

##
 # prepare app directory
 #
RUN mkdir /health \
  && chown nginx:nginx /health
RUN usermod -d /health nginx

##
 # set the user which be used by nginx
 #
USER nginx


##
 # clone repository
 #
RUN git clone --single-branch --depth 1 --branch ${LARAVEL_TAG:-master} https://github.com/laravel/laravel.git /health/repository


##
# Set the working directory
#
WORKDIR /health/repository


##
# Install app
#
RUN composer install
RUN composer require pragmarx/health:${LARAVEL_HEALTH_VERSION}
RUN composer require predis/predis
RUN php artisan vendor:publish --provider="PragmaRX\\Health\\ServiceProvider"


##
 # copy files
 #
COPY --chown=nginx:nginx ./build/ /
RUN chmod +x /health/*.sh


##
 # set environment variables
 #
ENV GIT_USER_EMAIL="health@health.io"
ENV GIT_USER_NAME="health"
ENV APP_URL="http://localhost:8087"


##
 # declare docker volumes
 #
VOLUME /health/repository/storage
VOLUME /health/repository/config/health

##
 # start up script
 #
USER root
CMD ["/health/start.sh"]
##
# image
#
FROM mysql:5.7

##
# MAINTAINER
#
LABEL maintainer="Antonio Carlos Ribeiro <acr@antoniocarlosribeiro.com>"

##
# variables
#
ARG root_home=/root

##
# add aliases
#
COPY .$root_home/.bashrc $root_home/.bashrc

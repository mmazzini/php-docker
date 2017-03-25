FROM php:7.1

MAINTAINER Florent Morselli <contact@morselli.fr>

RUN apt-get update
RUN apt-get install -y \
    libgmp-dev \
    libcurl3-dev \
    libssl-dev \
    git

RUN docker-php-ext-install gmp
RUN docker-php-ext-install curl

RUN git clone git://github.com/lt/php-curve25519-ext.git
RUN cd php-curve25519-ext; \
    phpize; \
    ./configure; \
    make; \
    make install;
RUN rm -rf php-curve25519-ext
RUN git clone git://github.com/encedo/php-ed25519-ext.git
RUN cd php-ed25519-ext; \
    phpize; \
    ./configure; \
    make; \
    make install;
RUN rm -rf php-ed25519-ext
ADD jose.ini /usr/local/etc/php/conf.d/

ENV COMPOSER_ALLOW_SUPERUSER 1
# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

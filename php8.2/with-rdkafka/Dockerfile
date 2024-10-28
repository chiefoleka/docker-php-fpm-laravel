FROM php:8.2.25-fpm-alpine

RUN apk update && apk add --no-cache \
    curl \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    librdkafka-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev \
    libpq-dev \
    unzip \
    icu-dev \
    g++ \
    make \
    autoconf \
    && docker-php-ext-install \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    mysqli \
    zip \
    gd \
    bcmath \
    mbstring \
    opcache \
    intl

RUN apk add --update nodejs npm

ARG PHPCONF_PATH=/usr/local/etc/php/conf.d
RUN yes | pecl install rdkafka
RUN echo "extension=rdkafka.so" > ${PHPCONF_PATH}/rdkafka.ini

RUN docker-php-ext-enable pdo_pgsql pdo_mysql sodium
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

EXPOSE 9000

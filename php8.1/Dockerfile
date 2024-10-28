FROM php:8.1.18-fpm-alpine3.17

RUN apk update && apk add --no-cache \
    curl \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev \
    libpq-dev \
    unzip \
    icu-dev \
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

RUN docker-php-ext-enable pdo_pgsql pdo_mysql sodium

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

EXPOSE 9000
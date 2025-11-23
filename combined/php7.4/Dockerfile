# Based on https://github.com/serversideup/docker-php
FROM serversideup/php:7.4-fpm-nginx

USER root
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    libxml2-dev  \ 
    libjpeg62-turbo-dev \
    libpng-dev \
    libfreetype6-dev \
    libwebp-dev; \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp; \
    docker-php-ext-install -j"$(nproc)" gd exif soap bcmath;
RUN install-php-extensions soap gd exif bcmath

ENV HEALTHCHECK_PATH=healthcheck \
    NGINX_SERVER_PORT=80 \
    PHP_ERROR_LOG="/var/log/php/error.log" \
    PHP_FPM_PM_MAX_CHILDREN=275 \
    PHP_FPM_PM_START_SERVERS=2 \
    PHP_FPM_PM_MIN_SPARE_SERVERS=1 \
    PHP_FPM_PM_MAX_SPARE_SERVERS=64\
    PHP_FPM_PM_MAX_REQUESTS=2000 \
    PHP_MEMORY_LIMIT="2048M" \
    PHP_OPCACHE_ENABLE="1" \
    PHP_OPCACHE_INTERNED_STRINGS_BUFFER="8" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="20000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="512" \
    PHP_OPCACHE_REVALIDATE_FREQ="2" \
    PHP_POST_MAX_SIZE="1024M" \
    PHP_SESSION_COOKIE_SECURE=false \
    PHP_UPLOAD_MAX_FILE_SIZE="1024M"

USER www-data
RUN mkdir -p /etc/nginx/conf.d

COPY --chmod=755 common/entrypoint.d/ /etc/entrypoint.d/
COPY --chmod=755 common/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --chmod=755 common/nginx/http.conf.template /etc/nginx/site-opts.d/http.conf.template
COPY --chmod=755 common/s6-overlay/check /etc/s6-overlay/s6-rc.d/nginx/data/check

RUN rm /etc/nginx/site-opts.d/https.conf.template

EXPOSE 80

HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD [ "sh", "-c", "curl --insecure --silent --location --show-error --fail http://127.0.0.1:$NGINX_SERVER_PORT/$HEALTHCHECK_PATH || exit 1" ]

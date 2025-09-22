# PHP-FPM 8 Docker Images for Laravel
This repository has images for the following php versions: `8.1`, `8.2` and `8.3`. These images are built on `php-fpm` and `alpine` linux distro, making them great for running a PHP server for your application. 

These images are created to work with Laravel using MySQL and Postgres, and ships with `composer` and `nodejs` for Laravel's frontend technologies. For a system that relies on kafka, there are images with `rdkafka` installed, so use that instead.

If you find any issues or have improvements to suggest, please open a ticket or raise a PR.

## Building
Images are to be built to be multiplatform (`linux/amd64` & `linux/arm64`). THe build command:
```bash
# example for PHP 7.4
docker buildx build \
  --push \
  --platform linux/amd64,linux/arm64 \
  -f php7.4/Dockerfile \
  -t chiefoleka/php-fpm-74-laravel:0.1.0-nginx \
  .
```

## Available images
### PHP 7.4 multi-platform
```bash
# php7.4
docker pull chiefoleka/php-fpm-74-laravel:0.1.0-nginx
```

### PHP 8.1
```bash
# php8.1
docker pull chiefoleka/php-fpm-81-laravel:0.1.0
```
```bash
# php8.1 with rdkafka
docker pull chiefoleka/php-fpm-81-laravel:0.1.0-rdkafka
```

### PHP 8.2
```bash
# php8.2
docker pull chiefoleka/php-fpm-82-laravel:0.1.0
```
```bash
# php8.2 with rdkafka
docker pull chiefoleka/php-fpm-82-laravel:0.1.0-rdkafka
```
```bash
# php8.2 with nginx
docker pull chiefoleka/php-fpm-82-laravel:0.1.2-nginx
```

### PHP 8.3
```bash
# php8.3
docker pull chiefoleka/php-fpm-83-laravel:0.1.0
```
```bash
# php8.3 with rdkafka
docker pull chiefoleka/php-fpm-83-laravel:0.1.0-rdkafka
```

Cheers!

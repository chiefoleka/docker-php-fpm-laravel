# PHP-FPM 8 Docker Images for Laravel
This repository has images for the following php versions: `8.1`, `8.2` and `8.3`. These images are built on `php-fpm` and `alpine` linux distro, making them great for running a PHP server for your application. 

These images are created to work with Laravel using MySQL and Postgres, and ships with `composer` and `nodejs` for Laravel's frontend technologies. For a system that relies on kafka, there are images with `rdkafka` installed, so use that instead.

If you find any issues or have improvements to suggest, please open a ticket or raise a PR.

## Available images
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
# php8.1
docker pull chiefoleka/php-fpm-82-laravel:0.1.0
```
```bash
# php8.1 with rdkafka
docker pull chiefoleka/php-fpm-82-laravel:0.1.0-rdkafka
```

### PHP 8.3
```bash
# php8.1
docker pull chiefoleka/php-fpm-83-laravel:0.1.0
```
```bash
# php8.1 with rdkafka
docker pull chiefoleka/php-fpm-83-laravel:0.1.0-rdkafka
```

Cheers!

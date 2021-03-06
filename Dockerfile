FROM php:7.2-fpm-alpine
MAINTAINER Valentin Prugnaud <valentin@whatdafox.com>

WORKDIR /var/www/html

RUN apk add zlib-dev libpng-dev libjpeg-turbo-dev freetype-dev

RUN docker-php-ext-configure zip && docker-php-ext-install zip pdo_mysql bcmath gd

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

EXPOSE 9000
CMD ["php-fpm"]

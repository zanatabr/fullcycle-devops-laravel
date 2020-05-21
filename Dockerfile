FROM php:7.4.6-fpm-alpine3.11

WORKDIR /var/www

RUN apk add bash mysql-client && \
    docker-php-ext-install pdo pdo_mysql && \
    rm -rf /var/www/html && \
    # install laravel
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    # install laravel
    composer create-project laravel/laravel .  && \
    # update dependencies 
    composer install && \
    cp .env.example .env && \
    php artisan key:generate && \
    php artisan config:cache && \
    ln -s public html

EXPOSE 9000
ENTRYPOINT ["php-fpm"]

FROM php:7.4.6-fpm-alpine3.11

WORKDIR /var/www

RUN apk add --no-cache openssl bash mysql-client && \
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


ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

EXPOSE 9000
ENTRYPOINT ["php-fpm"]

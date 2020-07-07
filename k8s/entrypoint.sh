#!/bin/bash
cd /var/www
php artisan config:cache
php artisan migrate
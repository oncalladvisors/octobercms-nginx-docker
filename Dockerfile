FROM richarvey/nginx-php-fpm:1.3.3
MAINTAINER Peter Olson <that0n3guy@users.noreply.github.com>

COPY ./ /var/www/html/

FROM richarvey/nginx-php-fpm:1.2.0
MAINTAINER Peter Olson <that0n3guy@users.noreply.github.com>

COPY ./ /var/www/html/

# install xdebug
RUN apk upgrade --update && apk add autoconf gcc musl-dev linux-headers libffi-dev augeas-dev python-dev make
RUN pecl install xdebug

# cleanup
RUN apk del gcc musl-dev linux-headers libffi-dev augeas-dev python-dev

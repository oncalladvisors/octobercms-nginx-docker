FROM richarvey/nginx-php-fpm:1.2.0
MAINTAINER Peter Olson <that0n3guy@users.noreply.github.com>

COPY ./ /var/www/html/

#RUN rm -r /var/www/html/src/themes && ln -s /var/www/html/conf/themes /var/www/html/src/themes
#RUN rm -r /var/www/html/src/plugins && ln -s /var/www/html/conf/plugins /var/www/html/src/plugins

# install xdebug
RUN apk upgrade --update && apk add autoconf gcc musl-dev linux-headers libffi-dev augeas-dev python-dev make
RUN pecl install xdebug

# cleanup
RUN apk del gcc musl-dev linux-headers libffi-dev augeas-dev python-dev

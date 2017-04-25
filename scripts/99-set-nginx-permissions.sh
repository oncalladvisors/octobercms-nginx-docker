#!/bin/bash

# from https://github.com/ngineered/nginx-php-fpm/blob/master/scripts/start.sh
if [ ! -z "$PUID" ]; then
  if [ -z "$PGID" ]; then
    PGID=${PUID}
  fi
  deluser nginx
  addgroup -g ${PGID} nginx
  adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx -u ${PUID} nginx
else
  # Always chown webroot for better mounting
  chown -Rf nginx.nginx /var/www/html
fi

#echo php_flag[display_errors] = on >> /usr/local/etc/php-fpm.conf

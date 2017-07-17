#!/bin/bash
if [[ "$DO_NOT_COPY_OCTOBER_CONFIG" == "1" ]] ; then
    echo 'DO_NOT_COPY_OCTOBER_CONFIG is set, I will not copy October config files.';
else
    echo 'copying October config files';
    cp /var/www/html/conf/octoberConf/*.php /var/www/html/src/config/
fi

echo 'copying nginx.conf file'
cp /var/www/html/conf/nginx/nginx.conf /etc/nginx/nginx.conf
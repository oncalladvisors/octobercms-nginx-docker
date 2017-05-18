#!/bin/bash
if [[ "$DO_NOT_COPY_OCTOBER_CONFIG" == "1" ]] ; then
    echo 'DO_NOT_COPY_OCTOBER_CONFIG is set, I will not copy October config files.';
else
    echo 'copying October config files';
    cp /var/www/html/conf/octoberConf/*.php /var/www/html/src/config/
fi

echo 'copying nginx.conf file'
cp /var/www/html/conf/nginx/nginx.conf /etc/nginx/nginx.conf

if [[ "$SYMLINK_PLUGINS" == "1" ]] ; then
	rm -r /var/www/html/src/plugins
	ln -s /var/www/html/conf/plugins /var/www/html/src/plugins
	echo "Symlinking plugins directory."
fi

if [[ "$SYMLINK_THEMES" == "1" ]] ; then
	rm -r /var/www/html/src/themes
	ln -s /var/www/html/conf/themes /var/www/html/src/themes
	echo "Symlinking themes directory."
fi

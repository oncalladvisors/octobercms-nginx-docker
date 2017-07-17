#!/bin/bash

XdebugFile='/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini'

# THIS ERROR is OK! You can ignore it:
#   /usr/local/bin/docker-php-ext-enable: line 83: nm: not found

# enable xdebug
if [[ "$ENABLE_XDEBUG" == "1" ]] ; then
  if [ -f $XdebugFile ]; then
  	echo xdebug already installed.
  else
  	echo "enabling xdebug";
		docker-php-ext-enable xdebug
		# see if file exists
		if [ -f $XdebugFile ]; then
			# See if file contains xdebug text.
			if grep -q xdebug.remote_enable "$XdebugFile"; then
				echo "Xdebug already enabled... skipping"
			else
			    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > $XdebugFile # Note, single arrow to overwrite file.
				echo "xdebug.remote_enable=1 "  >> $XdebugFile
				echo "xdebug.remote_log=/tmp/xdebug.log"  >> $XdebugFile
				echo "xdebug.remote_autostart=false "  >> $XdebugFile # I use the xdebug chrome extension instead of using autostart
				# NOTE: xdebug.remote_host is not needed here if you set an environment variable in docker-compose liek so `- XDEBUG_CONFIG=remote_host=192.168.111.27`.
				#       you also need to set an env var `- PHP_IDE_CONFIG=serverName=docker`
			fi
		fi
  fi
else
	if [ -f $XdebugFile ]; then
		echo "disabling xdebug" 
	  rm $XdebugFile
	fi
fi


#!/bin/bash

XdebugFile='/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini'

# THE ERROR:
#   /usr/local/bin/docker-php-ext-enable: line 83: nm: not found 
#   is OK!

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
				echo "xdebug.coverage_enable=0"  >> $XdebugFile
				echo "xdebug.remote_enable=1 "  >> $XdebugFile
				echo "xdebug.remote_connect_back=1"  >> $XdebugFile
				echo "xdebug.remote_log=/tmp/xdebug.log"  >> $XdebugFile
				echo "xdebug.remote_autostart=true "  >> $XdebugFile
			fi
		fi
  fi
else
	if [ -f $XdebugFile ]; then
		echo "disabling xdebug" 
	  rm $XdebugFile
	fi
fi


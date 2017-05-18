#!/bin/bash
# these are actions that need to be done after boot, not after build.  This is because we don't have DB access in build
#    because env vars aren't available yet.
APPDIR="/var/www/html/src"

#Should I run this script?
if [[ -z "${SKIP_COMPOSER}" ]]; then
  echo "Running composer install for main and plugins."
else
  echo "Skipping Composer"
  exit 0;
fi

#run composer and log to syslog.
cd /$APPDIR
COMPOSER_HOME="/root" composer install --no-dev --prefer-dist --optimize-autoloader --no-interaction

## run composer in each plugin directory

# http://stackoverflow.com/questions/3769137/use-git-log-command-in-another-folder
# http://briancoyner.github.io/blog/2013/06/05/git-sparse-checkout/
# note: https://github.com/dokku-alt/dokku-alt/issues/74
for d in $APPDIR/plugins/*/*/ ; do
    if [ -f "${d}composer.json" ]; then
        echo "--------------------------------------"
        echo "Running composer for $d"
        echo "--------------------------------------"
        cd $d
        COMPOSER_HOME="/root" composer install --no-dev --prefer-dist --optimize-autoloader --no-interaction
    fi
done

# Back to the main main directory
cd $APPDIR

#clear laravel cache
/usr/local/bin/php artisan cache:clear

# run october migrations if there is new code
/usr/local/bin/php artisan october:up

# optimize it.
mkdir -p $APPDIR/resources/views #artisan optimize needs this dir
/usr/local/bin/php artisan optimize

#make everyting read/writable from www-data
#chown -R www-data:www-data /app

# run this again for good measure
cd $APPDIR && /usr/local/bin/php artisan cache:clear


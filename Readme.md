#Octobercms container for local development to production.
This repo is designed to be used on the local environment.   Its been tested with "windows for docker" and should work on mac/linux as well (it is docker after all).

## How to use

* Clone with `git clone --recursive https://github.com/oncalladvisors/octobercms-nginx-docker.git`
* Run `docker-compose -f docker-compose-dev.yml up` to start the web, mysql, and adminer servers.
* I use this along with jwilders/nginx-proxy on my local so run the nginx-proxy also: https://gist.github.com/that0n3guy/92009a8cb33f2f99f90a03f7a9bf9e27

> Note: make sure you use the env variable `RUN_SCRIPTS=1`.

Your done, its up and running.

## Other options

This is built on top of https://github.com/ngineered/nginx-php-fpm/ so you can use any of the options associated with that docker container.    

## Features & Some things I added on top of `richarvey/nginx-php-fpm`:

* option xdebug - Enable with the env variable `ENABLE_XDEBUG=1`
    * you also need to set env vars `- XDEBUG_CONFIG=remote_host=you.local.ip.here` and `- PHP_IDE_CONFIG=serverName=NameUsedInPhpStormServerConfig`
* a lot of environment variable options (stolen from `https://github.com/Dragontek/octobercms`).   See "October variable options" below.
* composer and october:up is run on container startup (see 02-run-composer.sh).  Skip by setting `SKIP_COMPOSER=1` env var.
* I chose to add octobercms as a git submodule, not use the git importer built into `richarvey/nginx-php-fpm`.    I did this because I don't want october re-cloned every time the docker restarts.
* custom nginx files for octobercms.  In `richarvey/nginx-php-fpm` the nginx.conf file is not copied in (only the nginx-site.conf is copied) so I copy it in my startup scripts. 
* octobercms config files are copied from `conf/octoberConf` to `src/config` when container boots.   Add `DO_NOT_COPY_OCTOBER_CONFIG=1` to prevent this.

# October variable options
## Database Environment Variables
The following environment variables are honored for configuring your October instance:
* `-e OCTOBER_DB_DRIVER=...` (defaults to appropriate driver for linked database container. Must be specified as either 'mysql' or 'pgsql' for external database.)
* `-e OCTOBER_DB_HOST=...` (defaults to `mysql`)
* `-e OCTOBER_DB_PASSWORD=...` (defaults to the password for the user of the linked database container)
* `-e OCTOBER_DB_NAME=...` (defaults to `october_cms`)
* `-e OCTOBER_DB_USER=...` (defaults to `root`)

## Other Environment Variables
Most of the configuration settings can be set through environment variables.  The format always starts with `OCTOBER_` and then the configuration file name (e.g. `APP_`), and then the property name (e.g. `DEBUG`).  Property names that are camel case are split by the underscore, as are any sub properties.  Please refer to the configuration files for more detailed explanations and for valid settings.

### APP settings

* `-e OCTOBER_APP_DEBUG=...` (defaults to `false`)
* `-e OCTOBER_APP_URL=...` (defaults to `'http://localhost'`)
* `-e OCTOBER_APP_TIMEZONE=...` (defaults to `'UTC'`)
* `-e OCTOBER_APP_LOCALE=...` (defaults to `'en'`)
* `-e OCTOBER_APP_KEY=...` (defaults to randomly generated 32 bit key)
* `-e OCTOBER_APP_CIPHER=...` (defaults to `'AES-256-CBC'`)
* `-e OCTOBER_APP_LOG=...` (defaults to `'single'`)

### CMS settings
* `-e OCTOBER_CMS_EDGE_UPDATES=...` (defaults to `false`)
* `-e OCTOBER_CMS_ACTIVE_THEME=...` (defaults to `'demo'`)
* `-e OCTOBER_CMS_BACKEND_URI=...` (defaults to `'backend'`)
* `-e OCTOBER_CMS_DISABLE_CORE_UPDATES=...` (defaults to `false`)
* `-e OCTOBER_CMS_ENABLE_ROUTES_CACHE=...` (defaults to `false`)
* `-e OCTOBER_CMS_URL_CACHE_TTL=...` (defaults to `10`)
* `-e OCTOBER_CMS_PARSED_PAGE_CACHE_TTL=...` (defaults to `10`)
* `-e OCTOBER_CMS_ENABLE_ASSET_CACHE=...` (defaults to `false`)
* `-e OCTOBER_CMS_ENABLE_ASSET_MINIFY=...` (defaults to `null`)
* `-e OCTOBER_CMS_STORAGE_UPLOADS_DISK=...` (defaults to `'local'`)
* `-e OCTOBER_CMS_STORAGE_UPLOADS_PATH=...` (defaults to `'/storage/app/uploads'`)
* `-e OCTOBER_CMS_STORAGE_UPLOADS_FOLDER=...` (defaults to `'uploads'`)
* `-e OCTOBER_CMS_STORAGE_MEDIA_DISK=...` (defaults to `'local'`)
* `-e OCTOBER_CMS_STORAGE_MEDIA_PATH=...` (defaults to `'/storage/app/media'`)
* `-e OCTOBER_CMS_STORAGE_MEDIA_FOLDER=...` (defaults to `'media'`)
* `-e OCTOBER_CMS_CONVERT_LINE_ENDINGS=...` (defaults to `false`)
* `-e OCTOBER_CMS_LINK_POLICY=...` (defaults to `'detect'`)
* `-e OCTOBER_CMS_ENABLE_CSRF_PROTECTION=...` (defaults to `false`)

### FILESYSTEMS settings
* `-e OCTOBER_FILESYSTEMS_DEFAULT=...` (defaults to `'local'`)
* `-e OCTOBER_FILESYSTEMS_CLOUD=...` (defaults to `'s3'`)
* `-e OCTOBER_FILESYSTEMS_DISKS_S3_KEY=...` (defaults to `'your-key'`)
* `-e OCTOBER_FILESYSTEMS_DISKS_S3_SECRET=...` (defaults to `'your-secret'`)
* `-e OCTOBER_FILESYSTEMS_DISKS_S3_REGION=...` (defaults to `'your-region'`)
* `-e OCTOBER_FILESYSTEMS_DISKS_S3_BUCKET=...` (defaults to `'your-bucket'`)
* `-e OCTOBER_FILESYSTEMS_DISKS_RACKSPACE_KEY=...` (defaults to `'your-key'`)
* `-e OCTOBER_FILESYSTEMS_DISKS_RACKSPACE_USERNAME=...` (defaults to `'your-username'`)
* `-e OCTOBER_FILESYSTEMS_DISKS_RACKSPACE_CONTAINER=...` (defaults to `'your-container'`)

### MAIL settings
* `-e OCTOBER_MAIL_DRIVER=...` (defaults to `'mail'`)
* `-e OCTOBER_MAIL_HOST=...` (defaults to `'smtp.mailgun.org'`)
* `-e OCTOBER_MAIL_PORT=...` (defaults to `587`)
* `-e OCTOBER_MAIL_FROM_ADDRESS=...` (defaults to `'noreply@domain.tld'`)
* `-e OCTOBER_MAIL_FROM_NAME=...` (defaults to `'OctoberCMS'`)
* `-e OCTOBER_MAIL_ENCRYPTION=...` (defaults to `'tls'`)
* `-e OCTOBER_MAIL_USERNAME=...` (defaults to `null`)
* `-e OCTOBER_MAIL_PASSWORD=...` (defaults to `null`)
* `-e OCTOBER_MAIL_PRETEND=...` (defaults to `false`)

### SERVICES settings
* `-e OCTOBER_SERVICES_MAILGUN_DOMAIN=...` (defaults to `''`)
* `-e OCTOBER_SERVICES_MAILGUN_SECRET=...` (defaults to `''`)
* `-e OCTOBER_SERVICES_MANDRILL_SECRET=...` (defaults to `''`)
* `-e OCTOBER_SERVICES_SES_KEY=...` (defaults to `''`)
* `-e OCTOBER_SERVICES_SES_SECRET=...` (defaults to `''`)
* `-e OCTOBER_SERVICES_SES_REGION=...` (defaults to `'us-east-1'`)
* `-e OCTOBER_SERVICES_STRIPE_MODEL=...` (defaults to `'User'`)
* `-e OCTOBER_SERVICES_STRIPE_SECRET=...` (defaults to `''`)

### SESSION settings
* `-e OCTOBER_SESSION_DRIVER=...` (defaults to `'file'`)
* `-e OCTOBER_SESSION_LIFETIME=...` (defaults to `120`)
* `-e OCTOBER_SESSION_ENCRYPT=...` (defaults to `false`)
* `-e OCTOBER_SESSION_CONNECTION=...` (defaults to `null`)
* `-e OCTOBER_SESSION_TABLE=...` (defaults to `'sessions'`)
* `-e OCTOBER_SESSION_COOKIE=...` (defaults to `'october_session'`)
* `-e OCTOBER_SESSION_PATH=...` (defaults to `'/'`)
* `-e OCTOBER_SESSION_DOMAIN=...` (defaults to `null`)
* `-e OCTOBER_SESSION_SECURE=...` (defaults to `false`)
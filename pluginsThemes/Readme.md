# How to use

In this folder you should place your customized themes and plugins
folder.

The docker-compose file will mount a volume for each folder in here into the folder in the october src folder.  This
allows for quicker changes being reflected without have to restart the server.

## Notes

We are only working in this directory for dev. You should never commit
outside of this directory. Because of this it's not reconmended you use git submodules. You can
just clone the repo to symlink in (cloning the repo is reconmended).
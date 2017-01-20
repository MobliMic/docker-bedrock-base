#!/bin/bash
cd /var/www/html
composer install
apache2-foreground
exec "$@"

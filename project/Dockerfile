FROM php:7.0-apache

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev zip unzip git wget && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mysqli opcache

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite expires ssl

WORKDIR /tmp

COPY ./config/composer-install.sh ./

RUN ["chmod", "+x", "./composer-install.sh"]

RUN cat ./composer-install.sh | tr "\r" "\n" > ./composer-install.sh

RUN bash ./composer-install.sh

WORKDIR /var/www/html

RUN ls -alh

RUN mkdir /etc/apache2/ssl

COPY ./config/keys /etc/apache2/ssl

COPY ./config/wp-base.conf /etc/apache2/sites-available/wp-base.conf

RUN a2dissite 000-default && a2ensite wp-base

RUN service apache2 restart

COPY ./config/runtime.sh /usr/local/bin/

RUN ["chmod", "+x", "/usr/local/bin/runtime.sh"]

RUN cat /usr/local/bin/runtime.sh | tr "\r" "\n" > /usr/local/bin/runtime.sh

RUN ln -s /usr/local/bin/runtime.sh / # backwards compat

ENTRYPOINT ["runtime.sh"]

CMD ["apache2-foreground"]

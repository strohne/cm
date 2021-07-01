FROM php:7.1.2-apache
MAINTAINER jakobjuenger@freenet.de

WORKDIR /var/www/html

#mod rewrite
RUN a2enmod rewrite

# Add intl extension to PHP
RUN apt-get update && apt-get install -y libicu-dev 
RUN docker-php-ext-install intl
RUN docker-php-ext-enable intl

# Add git, zip and unzip
RUN apt-get update && apt-get -y --no-install-recommends install zip unzip git
RUN apt-get update && apt-get install -y zlib1g-dev && rm -rf /var/lib/apt/lists/* && docker-php-ext-install zip 

# Add composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# Add mySQL client
RUN apt-get update && apt-get install -y mysql-client && rm -rf /var/lib/apt
RUN docker-php-ext-install pdo_mysql

#Add gd and imagick
RUN apt-get update -y && apt-get install -y libpng-dev
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends
RUN pecl install imagick 
RUN docker-php-ext-enable imagick
RUN docker-php-ext-install gd
RUN apt-get install -y imagemagick imagemagick-doc

# Add poppler (pdfinfo, pdftotext)
RUN apt-get install -y poppler-utils

# Copy custom php.ini
COPY ./php.ini /usr/local/etc/php/
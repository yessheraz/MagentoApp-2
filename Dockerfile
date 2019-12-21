# Using php apache base image for the project.
FROM php:7.2-apache

# Setting environment variables.
ENV projectName=habibmall

# Installing dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install php7.2-zip

# Copying the directory content to apache public folder.
COPY . /var/www/html/$projectName

# Installing composer.
RUN curl -sS https://getcomposer.org/installer | php \ 
    && mv composer.phar /usr/local/bin/composer 

# Changing the work directory to project root folder.
WORKDIR /var/www/html/$projectName

# Changing permissions of the project files.
CMD find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
CMD find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
CMD chown -R $USER:www-data . # Ubuntu
CMD chmod u+x bin/magento

# Installing composer dependencies.
RUN composer install

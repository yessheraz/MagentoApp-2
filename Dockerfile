FROM pamidu/magento2:latest
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/
RUN chmod -R 777 /var/www/

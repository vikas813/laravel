FROM php:7.4-apache
WORKDIR /var/www/html/myapp/
RUN apt update -y
RUN apt install -y curl zip unzip nano net-tools
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php  
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN rm -rf /etc/apache2/sites-available/000-default.conf
RUN rm -rf /etc/apache2/sites-enabled/000-default.conf
RUN rm -rf /var/www/html/index.html
COPY 000-default.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/
COPY . /var/www/html/myapp/
RUN chown www-data:www-data /var/www/html/myapp/storage/ -R

EXPOSE 80

FROM php:7.3.6-fpm-alpine3.9

# adicionando bash e o mysql-client
# apk pois é o gerenciador de pacotes do alpine
RUN apk add --no-cache openssl bash mysql-client nodejs npm
# instala as extensões do pahp
RUN docker-php-ext-install pdo pdo_mysql

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www
RUN rm -rf /var/www/html

#instalando o composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# o copy também não vai funcionar, para que o composer install funcione realmente,
# pois o volume substitui os arquivos
#COPY . /var/www

# o composer tem que ser instalado no entrypoint pois aqui os arquivos ainda não estão no container
#RUN composer install

RUN ln -s public html

EXPOSE 9000
#ENTRYPOINT ["php-fpm"]


FROM php:8-alpine

# install composer
WORKDIR /usr/local/bin
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar composer

# install php extensions for laravel and mysql
RUN docker-php-ext-install pdo_mysql bcmath

# user ids from env (linux default 1000)
ARG uid=1000
ARG gid=1000
ARG user=laravel

# set user and group id
RUN addgroup -g $gid --system $user
RUN adduser --disabled-password --home "/app" --ingroup "$user" --uid "$uid" "$user"
RUN chown -R $user:$user /app

USER $user

# create default project and mv to home directory
WORKDIR /app
RUN composer create-project --prefer-dist laravel/laravel /tmp/app
RUN mv -n /tmp/app/* /tmp/app/.* .

CMD ["php", "artisan", "serve", "--host", "0.0.0.0"]

# Choose the desired PHP version
# Choices available at https://hub.docker.com/_/php/ stick to "-cli" versions recommended
FROM php:8.0.12-cli

ENV TARGET_DIR="/usr/local/lib/php-code-quality" \
  COMPOSER_ALLOW_SUPERUSER=1 \
  TIMEZONE=Europe/Paris \
  PHP_MEMORY_LIMIT=512M

RUN mkdir -p $TARGET_DIR

COPY ./composer.json $TARGET_DIR/composer.json
COPY ./composer.lock $TARGET_DIR/composer.lock


WORKDIR $TARGET_DIR

COPY --from=composer:2 /usr/bin/composer $TARGET_DIR/
# COPY composer-installer.sh $TARGET_DIR/
COPY composer-wrapper.sh /usr/local/bin/composer

RUN apt-get update -y ;\
  apt-get install -y wget \
      zip \
      git \
      libxml2-dev ;\
  docker-php-ext-install xml

RUN apt-get update -y  && apt-get install -y graphviz
RUN apt-get update -y  && apt-get install -y plantuml



# RUN chmod 744 $TARGET_DIR/composer-installer.sh
RUN chmod 744 /usr/local/bin/composer
RUN composer install --no-interaction

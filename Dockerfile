FROM alpine:latest
LABEL MAINTAINER Robert Weclawski <robert.weclawski@whitefoot.io>

COPY scripts/docker_logo.txt /

RUN \
  echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
  apk update && \
  apk upgrade && \
  apk add \
    apache2 \
    apache2-ssl \
    apache2-utils \
    apache2-error \
    php7 \
    php7-phar \
    php7-intl \
    php7-mysqlnd \
    php7-mbstring \
    php7-gettext \
    php7-xml \
    php7-enchant \
    php7-bcmath \
    php7-apache2 \
    php7-sysvsem \
    php7-gd \
    php7-pdo_mysql \
    php7-opcache \
    php7-posix \
    php7-soap \
    php7-openssl \
    php7-json \
    php7-zlib \
    php7-session \
    php7-redis \
    bash \
    curl \
    ca-certificates && \
    apk add php7-redis@testing && \
    curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/local/bin --filename=composer && \
    mkdir -p /run/apache2/ && \
  cat docker_logo.txt
COPY scripts/etc/apache2/conf.d/ssl.conf /etc/apache2/conf.d/ssl.conf
COPY scripts/etc/apache2/conf.d/custom.conf /etc/apache2/conf.d/custom.conf
COPY scripts/var/www/localhost/htdocs/index.php /var/www/localhost/htdocs/
COPY scripts/var/www/localhost/htdocs/env.php /var/www/localhost/htdocs/
EXPOSE 80 443 843

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]

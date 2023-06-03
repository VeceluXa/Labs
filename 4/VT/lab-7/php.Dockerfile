FROM ubuntu
RUN apt-get update && apt-get install -y iputils-ping && apt-get install dnsutils
FROM php:8.2-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql iconv
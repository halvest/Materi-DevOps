# Gunakan image dasar PHP 8.2 FPM
FROM php:8.2-fpm

# Install dependensi sistem
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    vim \
    unzip \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer (manual via skrip resmi)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Xdebug untuk code coverage saat testing
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Konfigurasi Xdebug 3 untuk mode coverage
RUN echo "xdebug.mode=coverage" >> /usr/local/etc/php/conf.d/dockerphp-ext-xdebug.ini

# Atur direktori kerja
WORKDIR /var/www/html

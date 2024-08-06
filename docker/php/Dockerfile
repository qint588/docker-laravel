FROM arm64v8/php:8.2-apache

# 1. Install development packages and clean up apt cache.
RUN apt-get update 

RUN apt-get install -y \
    curl \
    g++ \
    git \
    libbz2-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libpng-dev \
    libreadline-dev \
    libonig-dev \
    libzip-dev\
    sudo \
    unzip \
    zip \
    npm \
    libmagickwand-dev \
 && rm -rf /var/lib/apt/lists/*
# 2. Apache configs + document root.

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# 3. mod_rewrite for URL rewrite and mod_headers for .htaccess extra headers like Access-Control-Allow-Origin-
RUN a2enmod rewrite headers

RUN pecl install imagick

# 4. Start with base PHP config, then add extensions.
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-install \
    mbstring \
    bcmath \
    bz2 \
    calendar \
    iconv \
    intl \
    opcache \
    pdo_mysql \
    zip \
    gd

RUN docker-php-ext-enable imagick

RUN npm install npm@latest -g && \
    npm install n -g && \
    n latest

# 5. Composer.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
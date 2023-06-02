# Base image
FROM php:7.4-apache

# Arguments
ARG WORDPRESS_VERSION
ARG WORDPRESS_SHA1

# Set environment variables
ENV WORDPRESS_VERSION=${WORDPRESS_VERSION:-5.8.0} \
    WORDPRESS_SHA1=${WORDPRESS_SHA1:-f6bc20d45c7b77e78e665f0d54d5e5c0423e1a10}

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libjpeg-dev \
    libpng-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install -j "$(nproc)" \
    gd \
    mysqli \
    zip

# Download and extract WordPress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-6.2.2.tar.gz \
    && echo "a355d1b975405a391c4a78f988d656b375683fb2 *wordpress.tar.gz" | sha1sum -c - \
    && tar -xzf wordpress.tar.gz -C /var/www/html/ \
    && mv wordpress/* . \
    && rm wordpress.tar.gz \
    && chown -R www-data:www-data /var/www/html/

# Set the working directory
WORKDIR /var/www/html/

# Copy custom PHP configuration
COPY php.ini /usr/local/etc/php/conf.d/

# Expose port 80
EXPOSE 80

# Set the entry point and command
ENTRYPOINT ["docker-php-entrypoint"]
CMD ["apache2-foreground"]


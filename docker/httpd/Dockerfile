FROM base-image

USER root
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        apache2 \
        libapache2-mod-php \
        php \
        php-cli \
        php-common \
        php-curl \
        php-mbstring \
        php-pdo-mysql \
        php-zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /composer
COPY --from=scripts ./ /usr/local/bin
RUN get-composer-setup.sh && \
    mv ./composer.phar /usr/local/bin/composer

USER app

STOPSIGNAL SIGWINCH
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "apache2", "-DFOREGROUND" ]

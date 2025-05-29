FROM base-image

USER root
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        php-cli \
    && rm -rf /var/lib/apt/lists/*

USER app

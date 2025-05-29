FROM base-image

USER root
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        php-cli \
    && rm -rf /var/lib/apt/lists/*

USER app
WORKDIR /app

COPY --chown=app:app package.json package-lock.json ./
RUN npm ci --ignore-scripts

COPY --from=scripts ./ /usr/local/bin

COPY --chown=app:app ./ ./

CMD [ "cmd.sh" ]

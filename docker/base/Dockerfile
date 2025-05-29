ARG PSIM_IMAGE_VARIANT="bookworm"
FROM debian:${PSIM_IMAGE_VARIANT}

ARG APP_UID="1000"
ARG APP_GID="1000"

RUN groupadd -g "${APP_GID}" app && \
    useradd -u "${APP_UID}" -d /app -g app -m app

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        default-mysql-client \
        git \
        htop \
        jq \
        locales \
        make \
        netcat-openbsd \
        procps \
        python3 \
        vim \
    && rm -rf /var/lib/apt/lists/*

RUN echo "C.UTF-8 UTF-8" > /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

SHELL [ "/bin/bash", "-c" ]
CMD [ "/bin/bash" ]

HEALTHCHECK --interval=10s --timeout=5s --start-period=3s --retries=3 CMD [ "healthcheck-entrypoint.sh", "healthcheck.sh" ]

COPY --from=scripts ./ /usr/local/bin

USER app

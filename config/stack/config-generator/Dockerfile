FROM base-image

USER root

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        python3-venv \
    && rm -rf /var/lib/apt/lists/*

USER app
WORKDIR /app

RUN python3 -m venv venv
COPY --chown=app:app ./requirements.txt ./
RUN source ./venv/bin/activate && \
    pip3 install -r requirements.txt

COPY --chown=app:app ./ ./

ENTRYPOINT [ "/app/entrypoint.sh" ]

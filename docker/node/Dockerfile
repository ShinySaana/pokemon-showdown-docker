FROM base-image

ARG PSIM_NODE_VERSION

ENV PATH="/usr/local/node/bin:/usr/local/node/sbin:${PATH}"
RUN test -n "$PSIM_NODE_VERSION" || ( echo "PSIM_NODE_VERSION build argument is not defined" >&2 && exit 1 )

USER root

RUN arch="$( if [ "$(uname -m)" = "aarch64" ]; then echo "arm64"; else echo "x64"; fi )" && \
	mkdir /usr/local/node && cd /usr/local/node && \
	curl -fsSL https://nodejs.org/dist/v${PSIM_NODE_VERSION}/node-v${PSIM_NODE_VERSION}-linux-${arch}.tar.xz | tar -xJ --strip-components=1

USER app

FROM base-image

USER app
WORKDIR /app

COPY --chown=app:app package.json package-lock.json ./
RUN npm ci --ignore-scripts
RUN cd node_modules/better-sqlite3 && ../.bin/node-gyp rebuild --release

EXPOSE 8000
ENV NODE_TLS_REJECT_UNAUTHORIZED=0
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "./pokemon-showdown" ]

COPY --from=scripts ./ /usr/local/bin

# Everything after this will be re-executed on every "meaningful file" change.
# Keep it light!
COPY --chown=app:app ./ ./

# To ensure committed files inside are always in sync after an image upgrade,
# as `/database` is currently `VOLUME`-d in its entirety.
RUN cp -r ./databases ./databases-upstream

RUN npm run build

VOLUME /app/databases
VOLUME /app/logs

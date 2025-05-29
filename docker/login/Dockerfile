FROM base-image

USER root
RUN mkdir /migrations && chown app:app /migrations

USER app
WORKDIR /app

COPY --from=scripts ./ /usr/local/bin

COPY --chown=app:app package.json package-lock.json ./
RUN npm ci

COPY --from=pm2-config ./pm2.js /app/config/pm2.js

# Expected by config-loader
ENV CONFIG_PATH=/app/config/config.js

# Everything after this will be re-executed on every "meaningful file" change.
# Keep it light!
COPY --chown=app:app ./ ./
RUN npm run build

# What the actual fuck, PM2?
# Who hurt you???
# WHY?????
RUN ln -s /app/config/pm2.js ecosystem.config.js

EXPOSE 8080
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "node_modules/.bin/pm2", "start", "ecosystem.config.js", "--no-daemon" ]

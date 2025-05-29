FROM base-image

USER app
WORKDIR /app

COPY --chown=app:app ./LICENSE ./
COPY --chown=app:app ./composer.json ./
# I will only install PHP 7 at gunpoint
RUN composer update --ignore-platform-reqs 

COPY --chown=app:app --from=httpd-config ./ps.conf /etc/apache2/apache2.conf
COPY --from=scripts ./ /usr/local/bin

# VOLUME /app/SPRITES
VOLUME /app/caches
EXPOSE 80

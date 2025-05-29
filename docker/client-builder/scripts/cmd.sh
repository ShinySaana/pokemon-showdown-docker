#!/usr/bin/env bash

set -e

rm -f /app/caches/ready

npm run build full
htpatcher.sh /app/config/routes.json \
    /app/pokemonshowdown.com/.htaccess \
    /app/play.pokemonshowdown.com/.htaccess


touch /app/caches/ready

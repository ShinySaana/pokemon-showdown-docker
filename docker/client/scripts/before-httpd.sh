#!/usr/bin/env bash

set -e

until mysql -h "db-mysql" -P "3306" -u "$DB_USERNAME" -p"$DB_PASSWORD" -e "SELECT 1;" &> /dev/null; do
  echo "Waiting for MySQL to accept connections..."
  sleep 1
done

until test -f /app/caches/ready; do
  echo "Waiting for client-builder to be done..."
  sleep 1
done

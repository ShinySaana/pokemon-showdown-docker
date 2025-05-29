#!/usr/bin/env bash

set -e

until mysql -h "db-mysql" -P "3306" -u "$DB_USERNAME" -p"$DB_PASSWORD" -e "SELECT 1;" &> /dev/null; do
  echo "Waiting for MySQL to accept connections..."
  sleep 1
done


for filename in /app/src/schemas/ntbb-*.sql; do
    mysql -h "db-mysql" -P "3306" -u "$DB_USERNAME" -p"$DB_PASSWORD" showdown < $filename
done

for filename in /app/src/schemas/ntbb_*.sql; do
    mysql -h "db-mysql" -P "3306" -u "$DB_USERNAME" -p"$DB_PASSWORD" showdown < $filename
done


# for filename in /app/src/schemas/replays.sql; do
#     mysql -h "db-mysql" -P "3306" -u "$DB_USERNAME" -p"$DB_PASSWORD" replays < $filename
# done

# for filename in /app/src/schemas/ps_*.sql; do
#     mysql -h "db-mysql" -P "3306" -u "$DB_USERNAME" -p"$DB_PASSWORD" replays < $filename
# done

do_migration() {
    filename=$1

    mysql -h "db-mysql" -P "3306" -u "$DB_USERNAME" -p"$DB_PASSWORD" showdown < $filename
    echo -e $filename > $(basename $last_migration_filename)
}

reached_new=false
last_migration_filename=/migrations/last-success
for filename in /app/src/schemas/migrations/*.sql; do
    if $reached_new; then
        do_migration
    elif [ ! -f $last_migration_filename ]; then
        reached_new=true
        do_migration $filename
    elif [ "$(cat $last_migration_filename)" == "$filename" ]; then
        reached_new=true
    fi
done

"$@"

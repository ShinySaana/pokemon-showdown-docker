#!/usr/bin/env bash

set -e

make-symlink() {
    local from="$1"
    local to="$2"

    if [[ (! -L "$to") || (! -d "$to") ]]
    then
        rm -rf $to
        ln -s $from $to
    fi
}

make-symlink /app/databases-upstream/migrations  /app/databases/migrations
make-symlink /app/databases-upstream/schemas     /app/databases/schemas

/usr/bin/env bash -c "$@"

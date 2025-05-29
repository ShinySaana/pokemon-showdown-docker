#!/usr/bin/env bash

set -e

routes_file="$1"
shift

test -r "$routes_file"

replace_domain() {
    from=$1
    to=$2
    file=$3

    from_re="$(echo "$from" | sed 's/\./\\\./g')"
    to_re="$(echo "$to" | sed 's/\./\\\./g')"

    tmpfile="$(mktemp)"

    while IFS= read -r line; do
        line="${line//"$from"/$to}"
        line="${line//"$from_re"/$to_re}"
        echo "$line"
    done < "$file" > "$tmpfile"

    mv "$tmpfile" "$file"
}

for to_patch in "$@"; do
    replace_domain "replay.pokemonshowdown.com" "$(jq -r '.replays' "$routes_file")" "$to_patch"
    replace_domain "teams.pokemonshowdown.com" "$(jq -r '.teams' "$routes_file")" "$to_patch"
    replace_domain "dex.pokemonshowdown.com" "$(jq -r '.dex' "$routes_file")" "$to_patch"
    replace_domain "play.pokemonshowdown.com" "$(jq -r '.client' "$routes_file")" "$to_patch"
    replace_domain "pokemonshowdown.com" "$(jq -r '.root' "$routes_file")" "$to_patch"
done

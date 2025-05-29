#!/usr/bin/env bash

set -e

rm -f /tmp/httpd.pid

pre_hook_script="/usr/local/bin/before-httpd.sh"
if [[ -r "$pre_hook_script" && -x "$pre_hook_script" ]]; then
    /usr/local/bin/before-httpd.sh
fi

"$@"

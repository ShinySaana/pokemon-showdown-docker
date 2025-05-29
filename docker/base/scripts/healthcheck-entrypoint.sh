#!/usr/bin/env bash

# This script is a guard from making more than one entrypoint run at once.
# If you were to encounter such a behaviour, the correct fix would not 
# to increase the interval between healthchecks, but to ensure that only one is running at a time.
# Healthchecks are impotant.
# Some programs, like traefik, heavily rely on healthchecks being correct.

# It does not prevent healthchecks from doing their job, as a new healthcheck
# being ran while the last still lingers does result in an automatic failure.

# The very, very arbitrary exit code is there to signal that your
# system is encountering this behaviour.

# While this is supposed to already be taken care of by healthcheck options like
# timeout, this is mostly needed to circumvent weird, weird behaviour on macOS.

HEALTHCHECK_LOCK_FILE=/tmp/docker-healthcheck-pid.lock

if test -f "$HEALTHCHECK_LOCK_FILE"; then
    old_pid=$(cat $HEALTHCHECK_LOCK_FILE)

    if ps -p $old_pid > /dev/null
    then
        echo "healthcheck-entrypoint: $old_pid is still running."
        exit 169
    fi
fi

echo "$BASHPID" > "$HEALTHCHECK_LOCK_FILE"

"$@"
healthcheck_result=$?

rm -f "$HEALTHCHECK_LOCK_FILE"

exit $healthcheck_result
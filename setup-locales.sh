#!/usr/bin/env bash

set -e -x

declare -A locales
for loc in $(locale -a); do
    locales[$loc]=1
done

REQUIRED_LOCALES="en_US.utf8 en_GB.utf8 pt_BR.utf8"
UPDATE_LOCALE=""
for loc in $REQUIRED_LOCALES; do
    if [ -z "${locales[$loc]}" ]; then
        UPDATE_LOCALE=1
        sudo locale-gen $loc
    fi
done
if [ "$UPDATE_LOCALE" ]; then
    sudo update-locale
fi


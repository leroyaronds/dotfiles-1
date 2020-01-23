#!/bin/bash
set -e
#
# Set APT default options
APT="apt --quiet --assume-yes --no-install-recommends"
#
# Elevate permissions if needed
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
#
printf "# Updating System:\n"
$APT update && $APT upgrade && $APT autoremove && $APT autoclean
printf "# Updating System: Done\n"

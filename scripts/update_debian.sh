#!/bin/bash
set -e
#
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'
#
# apt-get with options
APT="apt-get --quiet --assume-yes"
#
# Elevate permissions if needed
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
#
# Update Debian
echo -e "\n${GREEN}# Updating System ...${RESET}"
$APT update && $APT upgrade && $APT autoremove && $APT autoclean

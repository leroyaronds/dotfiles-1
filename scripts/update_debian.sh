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
#
# Update Docker-compose
if command -v docker-compose >/dev/null; then
	echo -e "\n${GREEN}# Updating Docker-compose ...${RESET}"
	CURRENT_VERSION=`docker-compose version | grep -Po "docker-compose version (?:(\d+)\.?){4}" | awk -F ' ' '{print $3}'`
	AVAILABLE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
	echo -e "${YELLOW}Current: ${CURRENT_VERSION} - Available: ${AVAILABLE_VERSION}${RESET}"
	if [ $CURRENT_VERSION != $AVAILABLE_VERSION ]; then
		curl -#Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${AVAILABLE_VERSION}/docker-compose-`uname -s`-`uname -m`
		chmod +x /usr/local/bin/docker-compose
	fi
fi

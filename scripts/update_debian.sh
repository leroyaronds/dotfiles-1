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
# Update Debian
echo -e "\n${GREEN}# Updating System ...${RESET}"
$APT update && $APT upgrade && $APT autoremove && $APT autoclean
#
# Update Docker-compose
if command -v docker-compose >/dev/null; then
	echo -e "\n${GREEN}# Updating Docker-compose ...${RESET}"
	COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
	echo -e "${YELLOW}Latest Docker-compose version: ${COMPOSE_VERSION}${RESET}"
	curl -#Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`
	chmod +x /usr/local/bin/docker-compose
fi
#
# Update Minikube
if command -v minikube >/dev/null; then
	echo -e "\n${GREEN}# Updating Minikube ...${RESET}"
	curl -#Lo /usr/local/bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x /usr/local/bin/minikube
fi

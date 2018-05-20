#!/bin/sh
#
# Configure Ubuntu Server on DigitalOcean
#
# Username to add
USERNAME=marco
# Docker branch: stable | edge | nightly
DOCKER_BRANCH=nightly
#
# Upgrade system
apt-get update && apt-get upgrade -y
#
# Add needed packages
apt-get install -y sudo curl zsh tmux vim mosh git
#
# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) ${DOCKER_BRANCH}"
apt-get update
apt-get install docker-ce
#
# Docker Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
curl -#SLo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`
chmod +x /usr/local/bin/docker-compose
#
# Set timezone
timedatectl set-timezone Europe/Amsterdam
#
# Disable ssh root login
sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin no/g; }' /etc/ssh/sshd_config
#
# Add user
useradd -m -g users -G sudo,docker -s /bin/zsh ${USERNAME}
passwd ${USERNAME}
#

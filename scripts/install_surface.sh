#!/bin/bash
#
# Installation script for Surface GO

#  Set APT defaults
APT="apt --quiet --assume-yes --no-install-recommends"

# Elevate permissions
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Remove pre installed packages
$APT remove --purge gdm3 snapd bluez ubuntu-session gnome-session-bin gnome-settings-daemon cups rsyslog
$APT autoremove
$APT autoclean

# Install packages
apt-get install feh git i3 rxvt-unicode scdaemon vim zsh

# Create symbolic links to dotfiles
ln --symbolic ../.gitconfig $HOME/.gitconfig
ln --symbolic ../.gitignore $HOME/.gitignore
ln --symbolic ../.vimrc $HOME/.vimrc
ln --symbolic ../.xinitrc $HOME/.xinitrc
ln --symbolic ../.Xrecources $HOME/.Xresources
ln --symbolic ../.zshrc $HOME/.zshrc

# Change shell
chsh --shell /usr/bin/zsh

#!/bin/bash
#
# Installation script for Surface GO

#  Set APT defaults
APT="apt --quiet --assume-yes --no-install-recommends"

# Elevate permissions
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Remove installed packages
#
# bluez - Bluetooth
# cups - Printer
# gdm3 - Graphical login manager
# plymouth-theme-* - Stupid PURPLE ubuntu grub splashscreen
# unattended-upgrades - Autmatic background update daemon
# snapd - Extra package manager
# thermald - Thermal manager CPU manager
# xserver-xorg-video-intel - ** Intel driver which is causing screen FREEZES! (Removing this fixed the freezes) **
$APT remove --purge gdm3 snapd bluez ubuntu-session gnome-session-bin gnome-settings-daemon cups plymouth-theme-ubuntu-logo plymouth-theme-ubuntu-text thermald unattended-upgrades xserver-xorg-video-intel
$APT autoremove
$APT autoclean

# Install packages
$APT install brightnessctl cmus cpufrequtils git gpg i3status libgfshare-bin linux-headers-$(uname -r) mutt resolvconf kitty scdaemon sway swayidle swaylock tomb vim wireguard wpasupplicant zsh

# Create symbolic links to dotfiles
ln --symbolic ../.gitconfig ~/.gitconfig
ln --symbolic ../.gitignore ~/.gitignore
ln --symbolic ../.vimrc ~/.vimrc
ln --symbolic ../.zshenv ~/.zshenv
ln --symbolic ../.zshrc ~/.zshrc
ln --symbolic ../.config/sway ~/.config/sway
ln --symbolic ../.config/i3status ~/.config/i3status
ln --symbolic ../.config/kitty ~/.config/kitty

# Change shell
chsh --shell /usr/bin/zsh

# Set CPU goverer to 'performance'
cat >"/etc/default/cpufrequtils" <<EOL
GOVERNOR="powersave"
MIN_SPEED="400MHz"
MAX_SPEED="1600MHz"
EOL

# Disable ondemand CPU scaling
systemctl disable ondemand

# Remove kernel splash and enable login shell (Remove 'splash' and 'quiet')
# vim /etc/default/grub
# update-grub2

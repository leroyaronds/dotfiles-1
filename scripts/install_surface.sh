#!/bin/bash
#
# Installation script for Surface GO

#  Set APT defaults
APT="apt --quiet --assume-yes --no-install-recommends"

# Elevate permissions
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Remove pre installed packages
$APT remove --purge gdm3 snapd bluez ubuntu-session gnome-session-bin gnome-settings-daemon cups openvpn rsyslog thermald unattended-upgrades
$APT autoremove
$APT autoclean

# Install packages
apt-get install cpufrequtils feh git i3 resolvconf rxvt-unicode scdaemon vim wireguard xautolock xbacklight zsh

# Create symbolic links to dotfiles
ln --symbolic ../.gitconfig $HOME/.gitconfig
ln --symbolic ../.gitignore $HOME/.gitignore
ln --symbolic ../.vimrc $HOME/.vimrc
ln --symbolic ../.xinitrc $HOME/.xinitrc
ln --symbolic ../.Xrecources $HOME/.Xresources
ln --symbolic ../.zshrc $HOME/.zshrc
ln --symbolic ../.config/i3 $HOME/.config/i3
ln --symbolic ../.config/i3status $HOME/.config/i3status
ln --symbolic ../.config/dunst $HOME/.config/dunst

# Change shell
chsh --shell /usr/bin/zsh

# Enable 'tap to click' and 'brightness control'
mkdir -f /etc/X11/xorg.conf.d
cat >"/etc/X11/xorg.conf.d/10-surface.conf" <<EOL
Section "Device"
  Identifier "Device0"
  Driver     "intel"
  Option     "Backlight" "intel_backlight"
EndSection

Section "InputClass"
  Identifier      "touchpad"
  Driver          "libinput"
  MatchIsTouchpad "on"
  Option          "Tapping" "on"
  Option          "NaturalScrolling" "off"
  Option          "ClickMethod" "clickfinger"
EndSection
EOL

# Set CPU goverer to 'performance'
cat >"/etc/default/cpufrequtils" <<EOL
GOVERNOR="performance"
MIN_SPEED="1000MHz"
MAX_SPEED="1600MHz"
EOL

# Disable ondemand CPU scaling
systemctl disable ondemand

# Remove kernel splash and enable login shell (Remove 'splash' and 'quiet')
# vim /etc/default/grub
# update-grub2

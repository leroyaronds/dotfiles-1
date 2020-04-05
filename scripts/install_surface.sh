#!/bin/bash
#
# Installation script for Surface GO

#  Set APT defaults
APT="apt --quiet --assume-yes --no-install-recommends"

# Elevate permissions
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Fix ath10k
curl http://www.killernetworking.com/support/K1535_Debian/board.bin > board.bin
rm /lib/firmware/ath10k/QCA6174/hw2.1/board*
cp board.bin /lib/firmware/ath10k/QCA6174/hw2.1/
rm /lib/firmware/ath10k/QCA6174/hw3.0/board*
cp board.bin /lib/firmware/ath10k/QCA6174/hw3.0/

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
$APT install brightnessctl cmus cpufrequtils git gpg i3status kitty knockd libgfshare-bin linux-headers-$(uname -r) mutt qrencode pinentry-curses pinentry-gnome3 resolvconf scdaemon steghide sway swayidle swaylock tomb vim wireguard wl-clipboard wlfreerdp wpasupplicant zbar-tools zsh

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

# Add user to 'video' group to allow brightness control
usermod -aG video $USER

# Disable ondemand CPU scaling
systemctl disable ondemand

# Set powerbutton to suspend
cat >"/etc/systemd/logind.conf" <<EOL
[Login]
HandlePowerKey=suspend
EOL

# Fix mouse pointer in Firefox
gsettings set org.gnome.desktop.interface cursor-theme 'DMZ-White'

# Fix Microsoft Type Cover init fail
cat >"/etc/modprobe.d/blacklist-i2c-hid.conf" <<EOL
blacklist i2c_hid
EOL

# Remove kernel splash and enable login shell (Remove 'splash' and 'quiet')
# vim /etc/default/grub
# update-grub2

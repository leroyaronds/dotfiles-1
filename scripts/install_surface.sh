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
rm board.bin

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

# Cleanup repositories
cat >"/etc/apt/sources.list" <<EOL
deb http://ftp.nluug.nl/os/Linux/distr/ubuntu/ groovy main universe
deb http://ftp.nluug.nl/os/Linux/distr/ubuntu/ groovy-updates main universe
deb http://ftp.nluug.nl/os/Linux/distr/ubuntu/ groovy-security main universe
EOL
# Update repositories
$APT update

# Install packages
$APT install brightnessctl cmus cpufrequtils freerdp2-wayland git gpg grim i3status kitty knockd libgfshare-bin linux-headers-$(uname -r) qrencode pinentry-gnome3 resolvconf ripgrep scdaemon sshfs steghide sway swayidle swaylock tomb vim wireguard wl-clipboard wpasupplicant xwayland zbar-tools zsh

# Create symbolic links to dotfiles
ln --symbolic ../.gitconfig ~/.gitconfig
ln --symbolic ../.gitignore ~/.gitignore
ln --symbolic ../.vimrc ~/.vimrc
ln --symbolic ../.zshenv ~/.zshenv
ln --symbolic ../.zshrc ~/.zshrc
ln --symbolic ../.config/sway ~/.config/sway
ln --symbolic ../.config/i3status ~/.config/i3status
ln --symbolic ../.config/kitty ~/.config/kitty

# Set locale
cat >"/etc/default/locale" <<EOL
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
EOL

# Change shell
chsh --shell /usr/bin/zsh

# Set CPU goverer to 'performance' or 'powersave'
cat >"/etc/default/cpufrequtils" <<EOL
GOVERNOR="performance"
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

# Install Ledger USB detection
cat <<EOF > /etc/udev/rules.d/20-hw1.rules
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0004|4000|4001|4002|4003|4004|4005|4006|4007|4008|4009|400a|400b|400c|400d|400e|400f|4010|4011|4012|4013|4014|4015|4016|4017|4018|4019|401a|401b|401c|401d|401e|401f", TAG+="uaccess", TAG+="udev-acl"
EOF
udevadm trigger
udevadm control --reload-rules

# Remove kernel splash and enable login shell (Remove 'splash' and 'quiet')
# vim /etc/default/grub
# update-grub2

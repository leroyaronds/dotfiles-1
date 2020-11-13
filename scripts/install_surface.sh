#!/bin/bash
#
# Installation script for Surface GO

#  Set APT defaults
APT="apt --quiet --assume-yes --no-install-recommends"

# Elevate permissions
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# Fix ath10k
#curl http://www.killernetworking.com/support/K1535_Debian/board.bin > board.bin
#rm /lib/firmware/ath10k/QCA6174/hw2.1/board*
#cp board.bin /lib/firmware/ath10k/QCA6174/hw2.1/
#rm /lib/firmware/ath10k/QCA6174/hw3.0/board*
#cp board.bin /lib/firmware/ath10k/QCA6174/hw3.0/
#rm board.bin
# curl -o /lib/firmware/ath10k/QCA6174/hw3.0/board.bin https://raw.githubusercontent.com/kvalo/ath10k-firmware/master/QCA6174/hw3.0/board-2.bin
# curl -o /lib/firmware/ath10k/QCA6174/hw3.0/firmware-6.bin https://github.com/kvalo/ath10k-firmware/blob/master/QCA6174/hw3.0/4.4.1/firmware-6.bin_WLAN.RM.4.4.1-00157-QCARMSWPZ-1

# Create wpc-supplicant config
wpa_passphrase YOUR_SSID YOUR_PASSWORD > /etc/wpa_supplicant.conf

# Auto start network interface
cat >>"/etc/network/interfaces.d/wifi" <<EOL
# Wifi
auto wlp0s20f3
iface wlp0s20f3 inet dhcp
  pre-up wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp0s20f3 &
  pre-up sleep 4
  post-down pkill wpa_supplicant
EOL

# Fix DHCP client DNS override
echo 'make_resolv_conf() { :; }' > /etc/dhcp/dhclient-enter-hooks.d/leave_my_resolv_conf_alone
chmod 755 /etc/dhcp/dhclient-enter-hooks.d/leave_my_resolv_conf_alone
sed -i '/#DNS=/c\DNS=1.1.1.1#cloudflare-dns.com 9.9.9.9#dns.quad9.net' /etc/systemd/resolved.conf
sed -i '/#FallbackDNS=/c\FallbackDNS=1.1.1.1' /etc/systemd/resolved.conf

# Remove installed packages
#
# bluez - Bluetooth
# cups - Printer
# gdm3 - Graphical login manager
# plymouth-theme-* - Stupid PURPLE ubuntu grub splashscreen
# unattended-upgrades - Autmatic background update daemon
# snapd - Extra package manager
# xserver-xorg-video-intel - ** Intel driver which is causing screen FREEZES! (Removing this fixed the freezes) **
$APT remove --purge --auto-remove gdm3 snapd bluez ubuntu-session gvfs-daemons gnome-session-bin gnome-settings-daemon cups netplan.io network-manager plymouth sssd sssd-common ubuntu-wallpapers ubuntu-wallpapers-groovy unattended-upgrades xserver-xorg-video-intel
$APT autoremove
$APT autoclean

# Cleanup repositories
cat >"/etc/apt/sources.list" <<EOL
deb http://ftp.nluug.nl/os/Linux/distr/ubuntu/ groovy main universe
deb http://ftp.nluug.nl/os/Linux/distr/ubuntu/ groovy-updates main universe
deb http://ftp.nluug.nl/os/Linux/distr/ubuntu/ groovy-security main universe
EOL

# Extra repositories
cat >"/etc/apt/sources.list.d/misc.list" <<EOL
# Microsoft Visual Studio Code
deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main
# Puppet 5 (For puppet extention)
deb http://apt.puppetlabs.com bionic puppet5
# Signal messenger
deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main
EOL

# Update repositories
$APT update

# Install packages
$APT install brightnessctl cpufrequtils freerdp2-wayland git gpg grim i3status ifupdown intel-media-va-driver kitty knockd libgfshare-bin mpd mpc ncmpc qrencode pinentry-gnome3 ripgrep scdaemon sshfs steghide sway swayidle swaylock tomb vim wireguard wl-clipboard wpasupplicant xwayland zbar-tools zsh

# Create symbolic links to dotfiles
ln --symbolic ~/dotfiles/.gitconfig ~/.gitconfig
ln --symbolic ~/dotfiles/.gitignore ~/.gitignore
ln --symbolic ~/dotfiles/.vimrc ~/.vimrc
ln --symbolic ~/dotfiles/.zshenv ~/.zshenv
ln --symbolic ~/dotfiles/.zshrc ~/.zshrc
ln --symbolic ~/dotfiles/.config/sway ~/.config/sway
ln --symbolic ~/dotfiles/.config/i3status ~/.config/i3status
ln --symbolic ~/dotfiles/.config/kitty ~/.config/kitty
ln --symbolic ~/dotfiles/.config/todo ~/.config/todo

# Set locale
#cat >"/etc/default/locale" <<EOL
#LANG=en_US.UTF-8
#LC_ALL=en_US.UTF-8
#EOL

# Change shell
chsh --shell /usr/bin/zsh

# Set CPU goverer to 'performance' or 'powersave'
#cat >"/etc/default/cpufrequtils" <<EOL
#GOVERNOR="performance"
#MIN_SPEED="400MHz"
#MAX_SPEED="1600MHz"
#EOL

# Configure Thermald
cat >"/etc/thermald/thermal-conf.xml" <<EOL
<?xml version="1.0"?>
<ThermalConfiguration>
<Platform>
    <Name>Surface Pro 7</Name>
    <ProductName>*</ProductName>
    <Preference>QUIET</Preference>
    <ThermalZones>
        <ThermalZone>
            <Type>cpu</Type>
            <TripPoints>
                <TripPoint>
                    <SensorType>x86_pkg_temp</SensorType>
                    <Temperature>60000</Temperature>
                    <type>passive</type>
                    <ControlType>SEQUENTIAL</ControlType>
                    <CoolingDevice>
                        <index>1</index>
                        <type>rapl_controller</type>
                        <influence>100</influence>
                        <SamplingPeriod>10</SamplingPeriod>
                    </CoolingDevice>
                </TripPoint>
            </TripPoints>
        </ThermalZone>
    </ThermalZones>
</Platform>
</ThermalConfiguration>
EOL

# Add user to 'video' group to allow brightness control
usermod -aG video $USER

# Set powerbutton to suspend
cat >"/etc/systemd/logind.conf" <<EOL
[Login]
HandlePowerKey=suspend
EOL

# Fix mouse pointer in Firefox
gsettings set org.gnome.desktop.interface cursor-theme 'DMZ-White'

# Install Ledger USB detection
cat <<EOF > /etc/udev/rules.d/20-hw1.rules
# Nano S
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001|1000|1001|1002|1003|1004|1005|1006|1007|1008|1009|100a|100b|100c|100d|100e|100f|1010|1011|1012|1013|1014|1015|1016|1017|1018|1019|101a|101b|101c|101d|101e|101f", TAG+="uaccess", TAG+="udev-acl"
# Nano X
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0004|4000|4001|4002|4003|4004|4005|4006|4007|4008|4009|400a|400b|400c|400d|400e|400f|4010|4011|4012|4013|4014|4015|4016|4017|4018|4019|401a|401b|401c|401d|401e|401f", TAG+="uaccess", TAG+="udev-acl"
# HI-power
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev", ATTRS{idVendor}=="2c97"
EOF
udevadm trigger
udevadm control --reload-rules

# Add reboot fix for Surface Pro 7
cat >"/etc/default/grub" <<EOL
GRUB_CMDLINE_LINUX_DEFAULT="reboot=pci"
EOL
update-grub2

# Set default systemd runlevel to multi user
#systemctl set-default multi-user.target

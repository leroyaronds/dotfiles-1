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
deb http://nl.archive.ubuntu.com/ubuntu/ groovy main universe
deb http://nl.archive.ubuntu.com/ubuntu/ groovy-updates main universe
deb http://nl.archive.ubuntu.com/ubuntu/ groovy-security main universe
EOL

# Update repositories
$APT update

# Install packages
$APT install brightnessctl cpufrequtils fzf git gpg grim i3status ifupdown intel-media-va-driver iptables-persistent kitty knockd libgfshare-bin mpd mpc mutt ncmpc pass pass-extension-otp pinentry-gnome3 qrencode ripgrep scdaemon steghide sway swayidle swaylock syncthing tomb vim wireguard wl-clipboard wpasupplicant xwayland zbar-tools zsh

# Create symbolic links to dotfiles
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore
ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.config/flake8 ~/.config/flake8
ln -s ~/dotfiles/.config/i3status ~/.config/i3status
ln -s ~/dotfiles/.config/kitty ~/.config/kitty
ln -s ~/dotfiles/.config/mpd ~/.config/mpd
ln -s ~/dotfiles/.config/mutt ~/.config/mutt
ln -s ~/dotfiles/.config/sway ~/.config/sway
ln -s ~/dotfiles/.config/todo ~/.config/todo
ln -s ~/dotfiles/.config/xkb ~/.config/xkb

# Setup MPD
mkdir ~/.mpd
systemctl --user enable mpd.service

# Set locale
#cat >"/etc/default/locale" <<EOL
#LANG=en_US.UTF-8
#LC_ALL=en_US.UTF-8
#EOL

# MesloLGS NF fonts
#curl -o "/usr/local/share/fonts/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
#curl -o "/usr/local/share/fonts/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
#curl -o "/usr/local/share/fonts/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
#curl -o "/usr/local/share/fonts/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

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
    <ThermalSensors>
      <ThermalSensor>
        <Type>coretemp</Type>
        <Path>/sys/class/thermal/thermal_zone8/temp</Path>
        <AsyncCapable>0</AsyncCapable>
      </ThermalSensor>
    </ThermalSensors>
    <ThermalZones>
      <ThermalZone>
        <Type>cpu</Type>
        <TripPoints>
          <TripPoint>
            <SensorType>x86_pkg_temp</SensorType>
            <Temperature>60000</Temperature>
            <type>passive</type>
            <ControlType>PARALLEL</ControlType>
            <CoolingDevice>
              <index>1</index>
              <type>rapl_controller</type>
              <influence>50</influence>
              <SamplingPeriod>10</SamplingPeriod>
            </CoolingDevice>
            <CoolingDevice>
              <index>2</index>
              <type>intel_pstate</type>
              <influence>40</influence>
              <SamplingPeriod>10</SamplingPeriod>
            </CoolingDevice>
            <CoolingDevice>
              <index>3</index>
              <type>intel_powerclamp</type>
              <influence>30</influence>
              <SamplingPeriod>10</SamplingPeriod>
            </CoolingDevice>
            <CoolingDevice>
              <index>4</index>
              <type>cpufreq</type>
              <influence>20</influence>
              <SamplingPeriod>8</SamplingPeriod>
            </CoolingDevice>
            <CoolingDevice>
              <index>5</index>
              <type>Processor</type>
              <influence>10</influence>
              <SamplingPeriod>5</SamplingPeriod>
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

#####################
# ArchLinux Install #
#####################
#
# Sync time with NTP
timedatectl set-ntp true
# Partition disk
fdisk /dev/sda
# Create file system
mkfs.ext4 /dev/sda1
# Mount file system
mount /dev/sda1 /mnt
# Add local mirror
echo "Server = http://mirror.transip.net/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
# Install base system
pacstrap /mnt base
# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab
# Chroot into new system
arch-chroot /mnt
# Set timezone
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
# Sync HW clock
hwclock --systohc
# Set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
# Set hostname
echo "marco-dev" > /etc/hostname
# Change root password
passwd
# Enable dhcp client
systemctl enable dhcpcd
# Install boot loader (grub)
pacman -Syu grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
# Exit and reboot
exit
umount /mnt
reboot
#
#####################
# Install X desktop #
#####################
#
# Install packages
pacman -Syu zsh vim sudo openssh pass sylpheed firefox git xorg-server xorg-xinit rxvt-unicode openbox tint2 ttf-dejavu
# Enable sudo on wheel group
visudo
# Enable VirtualBox services
pacman -S virtualbox-guest-utils
systemctl enable vboxservice.service
# Add user
useradd -m -g users -G wheel,storage,power -s /bin/zsh marco
passwd marco
# end

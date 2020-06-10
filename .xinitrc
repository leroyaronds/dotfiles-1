# Init dbus
systemctl --user import-environment DISPLAY XAUTHORITY
if command -v dbus-update-activation-environment >/dev/null; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi
# Set background
if command -v feh >/dev/null; then
	feh --bg-center ~/dotfiles/background.png &
fi
# Turn screen off (10 min)
xset s 0 dpms 0 0 600 &
# Autolocker (5 min)
xautolock -time 5 -locker 'i3lock -c 000000 -f -n' &
# Load X resources
xrdb -load ~/.Xresources &
# Load custom keymap (caps+ijkl)
xmodmap ~/.xmodmap &
# Start Window Manager
exec i3

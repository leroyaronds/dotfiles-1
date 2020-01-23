# Fix pinentry on X11
dbus-update-activation-environment DISPLAY XAUTHORITY
# Set default shell
export SHELL=/bin/zsh
# Set default editor
export EDITOR=vim
# Set default browser
export BROWSER=firefox
# Set cache to RAM disk
export XDG_CACHE_HOME=/dev/shm
# Set config directory
export XDG_CONFIG_HOME=$HOME/.config
# Set data directory
export XDG_DATA_HOME=$HOME/.local/share/

# Start URXVT daemon
if command -v urxvtd >/dev/null; then
	urxvtd -q -o -f &
fi
# Set background
if command -v feh >/dev/null; then
	feh --bg-center $HOME/dotfiles/background.png &
fi
# Turn screen off (10 min)
xset s 0 dpms 0 0 600 &
# Autolocker (5 min)
xautolock -time 5 -locker $HOME/dotfiles/scripts/lock.sh &
# Load X resources
xrdb -load $HOME/.Xresources &
# Start VNC server
if command -v x0vncserver >/dev/null; then
	x0vncserver -passwordfile $HOME/.vnc/passwd -display :0 &
fi
# Start Window Manager
exec i3

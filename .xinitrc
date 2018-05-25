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

# Set background to black
# feh --bg-fill $HOME/wallpaper.png
if command -v xsetroot >/dev/null; then
	(sleep 1s && xsetroot -solid black) &
fi

# Start Tint
if command -v tint2 >/dev/null; then
	(sleep 1s && tint2) &
fi

# Start rxvt daemon
if command -v urxvtd >/dev/null; then
#	urxvtd -q -o -f
	(sleep 1s && LD_PRELOAD=/usr/lib/libswmhack.so.0.0 urxvtd -q -o -f) &
fi

# Start VirtualBox Client tools
if command -v VBoxClient >/dev/null; then
	(sleep 1s && VBoxClient-all) &
fi

# Turn screen blank after 5 min
(sleep 1s && xset s 300) &
# Lock screen after 10 min
(sleep 1s && xautolock -time 10 -locker "slock" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'Locking screen in 30 seconds'") &
# Turn screen off after 10 min
(sleep 1s && xset dpms 600 600 600) &
# Load X resources
(sleep 1s && xrdb -load ~/.Xresources) &

# Start Window Manager
exec spectrwm

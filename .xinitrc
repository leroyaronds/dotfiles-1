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

# Set background
if command -v feh >/dev/null; then
	feh --bg-scale $HOME/dotfiles/background.png &
fi

# Start rxvt terminal daemon
if command -v urxvtd >/dev/null; then
	urxvtd -q -o -f &
fi

# Start dunst notification daemon
if command -v dunst >/dev/null; then
	dunst -config $HOME/.dunstrc &
fi

# Start VirtualBox Client tools
if command -v VBoxClient >/dev/null; then
	VBoxClient-all &
fi

# Turn screen blank after 5 min
(sleep 1s && xset s 300) &
# Lock screen after 10 min
(sleep 1s && xautolock -time 10 -locker "slock" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'Locking screen in 30 seconds'") &
# Turn screen off after 10 min
(sleep 1s && xset dpms 600 600 600) &
# Load X resources
xrdb -load ~/.Xresources &

# Start Window Manager
exec spectrwm

# Set default shell
export SHELL=/bin/zsh
# Set default editor
export EDITOR=vim
# Set default browser
export BROWSER=firefox
# Set cache to RAM disk
export XDG_CACHE_HOME=/dev/shm
# Set config directory
export XDG_CONFIG_HOME=~/.config
# Set data directory
export XDG_DATA_HOME=~/.local/share/

# Start URXVT daemon
urxvtd -q -o -f &
# Set background
feh --bg-center ~/dotfiles/background.png &
# Turn screen off (10 min)
xset s 0 dpms 0 0 600 &
# Autolocker (5 min)
xautolock -time 5 -locker ~/dotfiles/scripts/lock.sh &
# Load X resources
xrdb -load ~/.Xresources &
# Start Window Manager
exec i3

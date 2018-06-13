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

# Turn screen blank after 5 min and off after 10 min
xset s 300 dpms 600 600 600 &
# Load X resources
xrdb -load ~/.Xresources &

# Start Window Manager
exec i3

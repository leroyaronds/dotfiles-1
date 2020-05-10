# Install Antigen if needed
ANTIGEN="${HOME}/.antigen/antigen.zsh"
if [ ! -f $ANTIGEN ]; then
	echo "Installing Antigen ..."
	curl --create-dirs -#sSLo $ANTIGEN git.io/antigen-nightly
fi

# Load Antigen
source $ANTIGEN
# Use oh-my-zsh
antigen use oh-my-zsh
# Load plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# Set theme
antigen theme minimal
# Apply settings
antigen apply

# History
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(gpg*|ssh*|tomb*)"
HISTSIZE=4000
SAVEHIST=2000

# Set default editor
export EDITOR=vim

# Vim style cursor movement
bindkey '^h' vi-backward-char
bindkey '^k' vi-up-line-or-history
bindkey '^l' vi-forward-char
bindkey '^j' vi-down-line-or-history

# Update GPG agent and socket
if command -v gpgconf >/dev/null; then
	export GPG_TTY="$(tty)"
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Aliases
alias g='git'
alias t='vim ~/todo.txt'
alias v='vim'

# Auto start SWAY
if [ -z $DISPLAY_WAYLAND ] && [ $(tty) = /dev/tty1 ] && command -v sway >/dev/null; then
	sway
fi

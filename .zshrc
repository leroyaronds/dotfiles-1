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
HISTSIZE=2000
SAVEHIST=2000

# Aliases
alias g='git'
alias k='kubectl'
alias t='vim ~/todo.txt'
alias v='vim'

# Auto start SWAY
if [ -z $DISPLAY_WAYLAND ] && [ $(tty) = /dev/tty1 ] && command -v sway >/dev/null; then
	sway
fi

# Update GPG agent and socket
if command -v gpg-connect-agent >/dev/null; then
	export GPG_TTY="$(tty)"
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	gpg-connect-agent updatestartuptty /bye >/dev/null
fi

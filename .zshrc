# Environment
export EDITOR="vim"
# ANT color logger
export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'

# Download URL of antigen
ANTIGEN_URL="git.io/antigen-nightly"
# Install Antigen if needed
ANTIGEN="${HOME}/.antigen/antigen.zsh"
if [ ! -f ${ANTIGEN} ]; then
	echo "Installing Antigen ..."
	curl --create-dirs -#SLo ${ANTIGEN} ${ANTIGEN_URL}
fi

# Load Antigen
source ${ANTIGEN}
# Use oh-my-zsh
antigen use oh-my-zsh
# Load plugins
antigen bundle docker-compose
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# Set theme
antigen theme minimal
# Apply settings
antigen apply

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Aliases
alias g="git"
alias t="tmux -2"
alias v="vim"
alias f="find . -type f -print | xargs grep"

# Set GPG password prompt to current TTY
if command -v gpg-connect-agent >/dev/null; then
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

# Export SSH socket to GPG agent
if command -v gpgconf >/dev/null; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

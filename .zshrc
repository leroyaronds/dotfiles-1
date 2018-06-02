# Environment
export EDITOR="vim"
# ANT color logger
export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'

# Install Antigen if needed
ANTIGEN="${HOME}/.antigen/antigen.zsh"
if [ ! -f ${ANTIGEN} ]; then
	echo "Installing Antigen ..."
	curl --create-dirs -#SLo ${ANTIGEN} git.io/antigen
fi

# Load Antigen
source ${ANTIGEN}
# Use oh-my-zsh
antigen use oh-my-zsh
# Load plugins
antigen bundle common-aliases
antigen bundle gpg-agent
antigen bundle git
antigen bundle docker
antigen bundle docker-compose
antigen bundle minikube
antigen bundle kubectl
antigen bundle pass
antigen bundle tmux
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
alias cdd="cd ~/repositories/docker/images/dev"
alias cdcrm="cd ~/dev/git/crm"

# Set GPG password prompt to current TTY
#if command -v gpg-connect-agent >/dev/null; then
#	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
#fi

# Export SSH socket to GPG agent
#if command -v gpgconf >/dev/null; then
#	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#fi

# Environment
export EDITOR="vim"
# ANT color logger
export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'

# Install Antigen if needed
ANTIGEN="~/.antigen/antigen.zsh"
if [ ! -f ${ANTIGEN} ]; then
	echo "Installing Antigen ..."
	curl --create-dirs -#SLo ${ANTIGEN} git.io/antigen
fi

# Load Antigen
source ${ANTIGEN}
# Use oh-my-zsh
antigen use oh-my-zsh
# Load plugins
antigen bundle docker
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
#
# Get ls color command
if ls --color > /dev/null 2>&1; then
	alias ls="ls -F --color" # Unix
else
	alias ls="ls -F -G" # OSX
fi
alias ll="ls -lh"
alias g="git"
alias n="vim ~/docs/notes.txt"
alias t="vim ~/docs/todo.txt ~/docs/done.txt"
# Tmux
alias ta="tmux -2 attach -t"
alias tnew="tmux -2 new -s"
alias tls="tmux -2 ls"
alias tkill="tmux kill-session -t"
# Edit config files
alias ev="vim ~/.vimrc"
alias et="vim ~/.tmux.conf"
alias ez="vim ~/.zshrc"
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
# Docker
alias dcb="docker-compose build"
alias dcu="docker-compose up -d"
alias dck="docker-compose kill"
alias dcd="docker-compose down"
alias dcp="docker-compose ps"
# Work
alias cdd="cd ~/repositories/docker/images/dev"
alias cdcrm="cd ~/dev/git/crm"
alias dcl='docker-compose logs -f --tail 1000 tomcat'

# Set GPG password prompt to current TTY
if command -v gpg-connect-agent >/dev/null; then
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

# Export SSH socket to GPG agent
if command -v gpgconf >/dev/null; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

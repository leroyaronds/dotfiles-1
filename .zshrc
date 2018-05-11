# Oh My Zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="minimal"
plugins=(docker zsh-syntax-highlightning)
source $ZSH/oh-my-zsh.sh

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Environment
export EDITOR="vim"
export TERM="xterm-256color"

# Dircolors
#LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
#export LS_COLORS

# Get LS color command
if ls --color > /dev/null 2>&1; then
	# Linux
	COLORFLAG="--color"
else
	# OSX
	COLORFLAG="-G"
fi

# Aliases
alias ls="ls -F ${COLORFLAG}"
alias ll="ls -lh"
alias g="git"
# Tmux
alias t=connect_tmux
alias ta="tmux -2 attach -t"
alias tnew="tmux -2 new -s"
alias tls="tmux -2 ls"
alias tkill="tmux kill-session -t"
# Edit config files
alias ev="vim ~/.vimrc"
alias et="vim ~/.tmux.conf"
alias ez="vim ~/.zshrc"
alias ep="vim *.ino *.cpp *.h"
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
# Docker
alias dcb="docker-compose build"
alias dcu="docker-compose up -d"
alias dck="docker-compose kill"
alias dcd="docker-compose down"

# Comp stuff
#zmodload zsh/complist 
#autoload -Uz compinit
#compinit
#zstyle :compinstall filename '${HOME}/.zshrc'
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*'   force-list always
#zstyle ':completion:*:*:killall:*' menu yes select
#zstyle ':completion:*:killall:*'   force-list always

# Prompt
#autoload -U colors zsh/terminfo
#colors
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git hg
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[blue]}%}%s%{${fg[cyan]}%}][%{${fg[yellow]}%}%b%{${fg[red]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

# Update VCS prompt on dir change
#precmd() {
#	vcs_info
#}

# Set custom prompt with VCS if available
#setprompt() {
#	setopt prompt_subst
#
#	PS2=$'%_>'
#	RPROMPT=$'${vcs_info_msg_0_}'
#	PROMPT='%F{green}%3~>%f '
#}
#setprompt

# Connect or Start TMUX
connect_tmux() {
if command -v tmux >/dev/null; then
	if [ -z ${TMUX} ]; then
		ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
		if [ -z ${ID} ]; then
			tmux new -n 'shell' -d -s main;
			tmux new-window -t main:2 -n 'prog';
			tmux select-window -t main:1;
			tmux -2 attach -t main;
		else
			tmux -2 attach -t "$ID"
		fi
	fi
fi
}

# Set GPG password prompt to current TTY
if command -v gpg-connect-agent >/dev/null; then
	gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

# Export SSH socket to GPG agent
if command -v gpgconf >/dev/null; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Work related
if [ -f ~/.zsh_work ]; then
	source ~/.zsh_work
fi
# end

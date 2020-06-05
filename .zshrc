# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
bindkey '^[[Z' reverse-menu-complete

# Fast directory switching
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -10
  fi
}
compdef _dirs d

# Prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' disable-patterns "${HOME}/work(|/*)"
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' formats '[%F{cyan}%b%f%c%u]'
zstyle ':vcs_info:git:*' actionformats '[%F{cyan}%b (%a)%f%c%u]'

setopt PROMPT_PERCENT
setopt PROMPT_SUBST
PROMPT='%2~ ${vcs_info_msg_0_}»%b '

# ZSH-syntax-highlighting
source ~/dotfiles/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
ZSH_HIGHLIGHT_MAXLENGTH=250
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
# To differentiate aliases from other command types
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# To disable highlighting of globbing expressions
ZSH_HIGHLIGHT_STYLES[globbing]='none'

# ZSH-autosuggestions
source ~/dotfiles/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ZSH-history-substring-search
source ~/dotfiles/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down

# History
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(gpg*|ssh*|tomb*)"
HISTSIZE=4000
SAVEHIST=2000
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Set default editor
export EDITOR=vim
# Set default browser
export BROWSER=firefox
# Set cache to RAM disk
export XDG_CACHE_HOME=/dev/shm
# Set config directory
export XDG_CONFIG_HOME=$HOME/.config
# Set data directory
export XDG_DATA_HOME=$HOME/.local/share
# Enable WAYLAND in Firefox
export MOZ_ENABLE_WAYLAND=1
# Set WAYLAND backend
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland-egl

# Update GPG agent and socket
if command -v gpgconf >/dev/null; then
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g apt='apt --quiet --assume-yes --no-install-recommends'
alias -g ls='ls --color=tty'

# Suffix aliases
alias -s txt=vim
alias -s md=vim
alias -s pdf=firefox

# Aliases
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias g='git'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias md='mkdir -p'
alias otp2secret='zbarimg -q --raw'
alias otp2image='qrencode -t ansiutf8'
alias rd=rmdir
alias sshb='ssh -fNT'
alias t='vim ~/todo.txt'
alias update='sudo apt update; sudo apt upgrade; sudo apt autoremove; sudo apt autoclean'
alias v='vim'

# Auto start SWAY
if [ -z $DISPLAY_WAYLAND ] && [ $(tty) = /dev/tty1 ] && command -v sway >/dev/null; then
    sway
fi

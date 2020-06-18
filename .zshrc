# Colors
if [[ -z "$LS_COLORS" ]]; then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
bindkey '^[[Z' reverse-menu-complete

# History
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(gpg*|ssh*|tomb*)"
HISTSIZE=4000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Fast directory switching
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' disable-patterns "~/ssh-mount(|/*)"
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' formats '[%F{cyan}%b%f%c%u]'
zstyle ':vcs_info:git:*' actionformats '[%F{cyan}%b (%a)%f%c%u]'
setopt PROMPT_PERCENT
setopt PROMPT_SUBST
PROMPT='%2~ ${vcs_info_msg_0_}» '

# Global aliases
alias -g apt='apt --quiet --assume-yes --no-install-recommends'

# Suffix aliases
alias -s txt=vim
alias -s md=vim
alias -s pdf=firefox

# Aliases
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias d='dirs -v | head -10'
alias dup='git -C ~/dotfiles pull --depth 1 && git -C ~/dotfiles submodule update --init --depth 1 --remote'
alias f='rg -i'
alias ff='find . -name'
alias g='git'
alias l='ls -lah'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias otp2secret='zbarimg -q --raw'
alias otp2image='qrencode -t ansiutf8'
alias sd='shred -u'
alias sshb='ssh -fNT'
alias t='tmux attach -t $(hostname) || tmux new -s $(hostname)'
alias update='sudo apt update; sudo apt upgrade; sudo apt --purge autoremove; sudo apt autoclean'
alias v='vim'

# ZSH-syntax-highlighting
if [[ -a ~/dotfiles/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/dotfiles/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
    ZSH_HIGHLIGHT_MAXLENGTH=250
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
    ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[globbing]='none'
fi

# ZSH-autosuggestions
if [[ -a ~/dotfiles/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/dotfiles/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# ZSH-history-substring-search
if [[ -a ~/dotfiles/submodules/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source ~/dotfiles/submodules/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[1;5A' history-substring-search-up
    bindkey '^[[1;5B' history-substring-search-down
fi

# Update GPG agent and socket
if command -v gpgconf >/dev/null; then
    gpgconf --launch gpg-agent
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Auto start SWAY
if [[ -z "$DISPLAY_WAYLAND" ]] && [[ $(tty) == /dev/tty1 ]] && command -v sway >/dev/null; then
    sway
fi

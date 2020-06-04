# Include extentions
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/ohmyzsh/lib/directories.zsh
source ~/dotfiles/zsh/ohmyzsh/lib/git.zsh
source ~/dotfiles/zsh/ohmyzsh/lib/theme-and-appearance.zsh
source ~/dotfiles/zsh/ohmyzsh/themes/minimal.zsh-theme

# History
HISTFILE=~/.zsh_history
HISTORY_IGNORE="(gpg*|ssh*|tomb*)"
HISTSIZE=4000
SAVEHIST=2000

# Set default editor
export EDITOR=vim

# Update GPG agent and socket
if command -v gpgconf >/dev/null; then
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Global aliases
alias -g apt='apt --quiet --assume-yes --no-install-recommends'

# Suffix aliases
alias -s txt=vim
alias -s md=vim
alias -s pdf=firefox

# Aliases
alias g='git'
alias otp2secret='zbarimg -q --raw'
alias otp2image='qrencode -t ansiutf8'
alias sshb='ssh -fNT'
alias t='vim ~/todo.txt'
alias update='sudo apt update; sudo apt upgrade; sudo apt autoremove; sudo apt autoclean'
alias v='vim'

# Auto start SWAY
if [ -z $DISPLAY_WAYLAND ] && [ $(tty) = /dev/tty1 ] && command -v sway >/dev/null; then
    sway
fi

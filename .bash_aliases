# ALIASES
alias g='git'
alias ll='ls -l'

# TMUX SCRIPTING
if command -v tmux >/dev/null; then
  if [ -z ${TMUX} ]; then
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
    if [ -z ${ID} ]; then
      tmux -2 new -d -s main -n 'BASH';
      tmux new-window -t main:2 -n 'GB';
      tmux new-window -t main:3 -n 'MM';
      tmux select-window -t main:1;
      tmux attach -t main;
    else
      tmux -2 attach -t "$ID"
    fi
  fi
fi

# TMUX SCRIPTING
if command -v tmux >/dev/null; then
  if [ -z ${TMUX} ]; then
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
    if [ -z ${ID} ]; then
      tmux new -s $(hostname);
    else
      tmux attach -t "$ID"
    fi
  fi
fi

# Automatic start/restore TMUX on servers
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    tmux attach -t $(hostname) || tmux new -s $(hostname)
fi

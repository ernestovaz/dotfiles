#!/bin/bash
# Create a tiled dashboard of all agent windows in the agents session
SESSION="agents"

# Get all non-scratch windows
windows=$(tmux list-windows -t "$SESSION" -F "#{window_index}:#{window_name}" | grep -v "scratch\|dashboard")

if [ -z "$windows" ]; then
    echo "No agent windows to show"
    exit 0
fi

# If dashboard window exists, kill it first
tmux kill-window -t "$SESSION:dashboard" 2>/dev/null

# Create dashboard window
tmux new-window -t "$SESSION" -n "dashboard"

# For each agent window, capture its current output and show in a pane
first=true
for win in $windows; do
    idx=$(echo "$win" | cut -d: -f1)
    name=$(echo "$win" | cut -d: -f2)
    
    if [ "$first" = true ]; then
        # First pane — rename existing
        tmux send-keys -t "$SESSION:dashboard" "tmux capture-pane -t $SESSION:$idx -p | tail -40" Enter
        first=false
    else
        # Split and show
        tmux split-window -t "$SESSION:dashboard" -h "watch -n5 -t 'tmux capture-pane -t $SESSION:$idx -p 2>/dev/null | tail -40'"
    fi
done

# Tile evenly
tmux select-layout -t "$SESSION:dashboard" even-horizontal

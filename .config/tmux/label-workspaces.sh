#!/bin/bash
# Labels tmux sessions with their AeroSpace workspace, then opens choose-tree

# Get aerospace window info once
AERO_WINDOWS=$(aerospace list-windows --all --format '%{app-pid} %{workspace}' 2>/dev/null)

# Label each session
tmux list-clients -F '#{client_pid} #{session_name}' | while IFS=' ' read -r client_pid session_name; do
    # Walk: tmux client -> shell -> login -> ghostty
    shell_pid=$(ps -p "$client_pid" -o ppid= 2>/dev/null | tr -d ' ')
    login_pid=$(ps -p "$shell_pid" -o ppid= 2>/dev/null | tr -d ' ')
    ghostty_pid=$(ps -p "$login_pid" -o ppid= 2>/dev/null | tr -d ' ')

    if [[ -n "$ghostty_pid" ]]; then
        workspace=$(echo "$AERO_WINDOWS" | awk -v pid="$ghostty_pid" '$1 == pid {print $2; exit}')
        if [[ -n "$workspace" ]]; then
            tmux set-option -t "$session_name" @workspace "$workspace"
        else
            tmux set-option -t "$session_name" @workspace "-"
        fi
    else
        tmux set-option -t "$session_name" @workspace "-"
    fi
done

# Open session picker
tmux choose-tree -sF '#{session_name} [#{@workspace}] (#{session_windows} windows)'

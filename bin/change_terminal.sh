cmd="alacritty"
tmux new-session -d
tmux send-keys "$cmd" C-m
tmux dettach
# Close active window (gnome-terminal since the new one hasn't loaded yet)
xdotool key --clearmodifiers Ctrl+Shift+Q key --clearmodifiers KP_Enter

# Setup fzf ---------
export FZF_DEFAULT_OPTS='--height 40% --tmux'

if [[ ! "$PATH" == */home/juhani/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/juhani/.fzf/bin"
fi

eval "$(fzf --bash)"

f() {
  local target
  target=$(find ~/ -type f | fzf)

  if [ -n "$target" ]; then 
    nvim "$target"
  fi
}

d() {
  local target
  local session_name

  target=$(find ~/ -type d | fzf)
  session_name=$(echo "$target" | awk -F'/' '{print $NF}')

  if [ -n "$target" ]; then 
 
    if [ "$(tmux has-session -t "$session_name" 2>/dev/null)" != 0 ]; then
      tmux new-session -s "$session_name" -c "$target" -d
    fi

    tmux switch-client -t "$session_name"
  fi
}

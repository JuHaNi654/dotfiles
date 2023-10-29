#!/bin/bash
does_exists () {
  if ! command -v "$1" &> /dev/null
  then
    echo "$1 could not be found"
    exit
  fi
}

commands=("curl" "git")
for cmd in "${commands[@]}"; do
  does_exists "$cmd"
done 

if ! command -v vim &> /dev/null
then 
  echo "Skipping vim plugin manager installation"
else 
  echo "Downloading vim plugin manager"
  curl -sfLo ~/.vim/autoload/plug.vim --create-dirs \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" 
fi

if ! command -v tmux &> /dev/null
then 
  echo "Skipping tmux plugin manager installation"
else
  echo "Downloading tpm tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
fi

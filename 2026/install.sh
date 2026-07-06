#!/bin/bash

ERROR="\033[0;31m"
SUCCESS="\033[0;32m"
WARNING="\033[1;33m"
NC="\033[0m"

target_dir=$HOME
pkg_dir="$(pwd)"

echo ""
echo "Dotfiles installer"
echo "Target directory: $target_dir"
echo "PKG directory: $pkg_dir"
echo ""

use_rsync() {
  for entry in "$1"/.*; do
    target=$(basename "$entry")
    if [ "$target" = "." ] || [ "$target" = ".." ]; then
      continue
    fi

    if [ -f $entry ]; then 
      echo " Copying $target to $target_dir"
      rsync -a "$entry" "$target_dir"
      continue
    fi

    target_path="$target_dir/$target"
    if [ ! -d "$target_path" ]; then 
      echo " path doesn't exists... creating new one"
      mkdir -p "$target_path"
    fi

    for config in "$entry"/*; do
      config_name=$(basename "$config")

      if [ "$config_name" = "." ] || [ "$config_name" = ".." ]; then
        continue
      fi

      echo " Copying $config_name to $target_path"
      rsync -a "$config" "$target_path"
      if [ $? -ne 0 ]; then
        echo "quitting installation"
        exit 1
      fi 
    done
  done
}

use_stow() {
  stow -t "$target_dir" "$2"
}

is_available() {
  if ! command -v "$1" &>/dev/null; then
    echo -e "${ERROR}$1 is not available${NC}"
  fi
}

install_cmd="use_rsync"

# Checks if system has required packages/tools installed
tools=("stow", "rsync")
for tool in "${tools[@]}"; do
  is_available "$tool"
done

if ! command -v stow &>/dev/null; then
  if ! command -v rsync &>/dev/null; then 
    echo "no stow or rsync found in system... quitting installation"
    exit 1
  fi

  echo "Stow not found. Fallback to rsync"
else
  echo "Using stow to install config files"
  install_cmd="use_stow"
fi

for pkg in "$pkg_dir"/*; do
  name=$(basename "$pkg")

  if [ "$name" = "install.sh" ]; then
    continue
  fi

  echo "Checking if $name is installed:"
  if ! command -v "$name" &>/dev/null; then
    echo -e " ${WARNING}$name not found, skipping installation${NC}"
    continue
  else
    echo " $name found, installing config files"
    $install_cmd "$pkg" "$name"
    echo -e " ${SUCCESS}$name config installed successfully${NC}"
  fi
done

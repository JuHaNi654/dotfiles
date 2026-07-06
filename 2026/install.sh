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

use_copy() {
  for target in "$1"/.*; do
    if [ "$name" = "." ] || [ "$name" = ".." ]; then
      continue
    fi

    name="$target_dir"/$(basename "$target")
    for folder in "$target"/*; do
      echo "Copying $folder to $name"
      cp -r "$folder" "$name"
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

install_cmd="use_copy"

# Checks if system has required packages/tools installed
tools=("stow")
for tool in "${tools[@]}"; do
  is_available "$tool"
done

if ! command -v stow &>/dev/null; then
  echo "Stow not found. Fallback to copying config files"
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

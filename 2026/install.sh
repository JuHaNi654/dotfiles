#!/bin/bash

target_dir=$HOME
pkg_dir="$(pwd)"

echo "Dotfiles installer"
echo "Target directory: $target_dir"
echo "PKG directory: $pkg_dir"

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

is_installed() {
  if ! command -v "$1" &>/dev/null; then
    echo "$1 could not be found"
    exit 1
  fi
}

install_cmd="use_copy"

# Checks if system has required packages/tools installed
tools=("stow")
for tool in "${tools[@]}"; do
  is_installed "$tool"
done

if ! command -v stow &>/dev/null; then
  echo "Stow not found. Fallback to copying config files"
else
  echo "Using stow to install config files"
  install_cmd="use_stow"
fi

echo ""

for pkg in "$pkg_dir"/*; do
  name=$(basename "$pkg")

  if [ "$name" = "install.sh" ]; then
    continue
  fi

  echo "Checking if $name is installed:"
  if !command -v "$name" &>/dev/null; then
    echo " $name not found, skipping installation"
    continue
  else
    echo " $name found, installing config files"
    $install_cmd "$pkg" "$name"
  fi
  echo " $name config installed successfully"
done

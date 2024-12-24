#!/bin/bash

REPO_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

install_neovim () {
  while ! command -v nvim &> /dev/null; do
    echo "Please install nvim before continuing (brew install neovim)..."
    read
  done
  ln -sTf "$REPO_DIR/configs/nvim" ~/.config/nvim

  echo "- Link created"
  echo "- Execute: sudo apt install curl xdotool xclip python3 universal-ctags gdb ripgrep lua-language-server"
}


install_feh() {
  while ! command -v feh &> /dev/null; do
    echo "Please install feh before continuing (sudo apt install feh)..."
    read
  done

  ln -sTf "$REPO_DIR/configs/feh" ~/.config/feh

  echo "- Link created"
}
# install_neovim
# install_feh

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

install_zsh () {
  if ! command -v zsh &> /dev/null; then
    echo "- Installing zsh..."
    sudo apt install zsh
  fi

  echo "- Changing the shell..."
  chsh -s /bin/zsh
  if [[ $? -ne 0 ]]; then
    echo "Error changing the shell, please try manually"
    exit 1
  fi

  echo "- Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "- Installing powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

  echo "- Installing autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  echo "- Installing syntax highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  echo "   - Add this for Oh My Zsh to load (inside ~/.zshrc):"
  echo "          ZSH_THEME=\"powerlevel10k/powerlevel10k\""
  echo "          # ..."
  echo "          plugins=("
  echo "              # other plugins..."
  echo "              zsh-autosuggestions"
  echo "              zsh-syntax-highlighting"
  echo "          )"
}

install_feh() {
  if ! command -v feh &> /dev/null; then
    echo "- Installing feh..."
    sudo apt install feh
  fi

  ln -sTf "$REPO_DIR/configs/feh" ~/.config/feh

  echo "- Link created"
}

install_rofi() {
  if ! command -v rofi &> /dev/null; then
    echo "- Installing rofi..."
    sudo apt install rofi rofi-dev qalc autoconf libtool
  fi

  ln -sTf "$REPO_DIR/configs/rofi/" ~/.config/rofi
  echo "- Link created"

  mkdir -p compiled
  cd compiled

  echo "- Compiling rofi-calc..."
  if [[ -d "rofi-calc" ]] ; then
    cd rofi-calc && git pull
  else
    git clone https://github.com/Ezee1015/rofi-calc
    cd rofi-calc
  fi
  mkdir -p m4 && autoreconf -i && mkdir -p build && cd build/ && ../configure && make && sudo make install
}

install_dunst() {
  if ! command -v dunst &> /dev/null; then
    echo "- Installing dunst..."
    sudo apt install dunst
  fi

  ln -sTf "$REPO_DIR/configs/dunst/" ~/.config/dunst
  echo "- Link created"
}

# install_neovim
# install_zsh
# install_feh
# install_rofi

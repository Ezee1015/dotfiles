#!/bin/bash

REPO_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

install_neovim () {
  while ! command -v nvim &> /dev/null; do
    echo "Please install nvim before continuing (brew install neovim)..."
    read
  done
  ln -sTf "$REPO_DIR/configs/nvim" ~/.config/nvim

  echo "- Copying .desktop file..."
  sudo cp desktop-entries/neovim.desktop /usr/share/applications

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

  ln -sTf "$REPO_DIR/configs/dunst" ~/.config/dunst
  echo "- Link created"
}

install_i3() {
  echo "- Install for i3: sudo apt install i3-wm i3lock numlockx lxappearance pavucontrol lm-sensors thunar breeze-icon-theme scrot xfce4-clipman-plugin perl build-essential acpi network-manager-gnome sqlite3 ffmpeg gvfs gvfs-backends playerctl"
  echo "- For Qt compatibility install: sudo apt install qt5ct qt5-style-plugins"
  echo -e "\n\n Press enter when ready..."
  read

  ln -sTf "$REPO_DIR/configs/i3" ~/.config/i3

  # Install scrot
  echo "- Installing scrot..."
  sudo cp i3-scrot/i3-scrot /usr/bin/

  # Install i3blocks
  echo "- Installing i3blocks..."
  mkdir -p compiled
  cd compiled
  if [[ -d "i3blocks" ]] ; then
    cd i3blocks && git pull
  else
    git clone https://github.com/Ezee1015/i3blocks
    cd i3blocks
  fi
  ./autogen.sh && ./configure && make && sudo make install
  cd ../..

  # Install font
  echo "- Installing fonts..."
    # Iosevka
  if [[ -d /usr/share/fonts/truetype/iosevka ]]; then
    sudo rm -r /usr/share/fonts/truetype/iosevka
  fi
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.tar.xz -P /tmp/ && sudo mkdir /usr/share/fonts/truetype/iosevka && sudo tar -xf /tmp/Iosevka.tar.xz -C /usr/share/fonts/truetype/iosevka
    # Hack
  if [[ -d /usr/share/fonts/truetype/hack ]]; then
    sudo rm -r /usr/share/fonts/truetype/hack
  fi
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz -P /tmp/ && sudo mkdir /usr/share/fonts/truetype/hack && sudo tar -xf /tmp/Hack.tar.xz -C /usr/share/fonts/truetype/hack

	# Qt theme control is `qt5ct`. Change to qt6ct when using Qt 6
  if ! grep "QT_QPA_PLATFORMTHEME=qt5ct" /etc/environment ; then
    echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment
  fi

  echo "- Instalation finished. Is recommended to install: sudo apt install kdeconnect"
}

install_alacritty() {
  mkdir -p compiled
  cd compiled

  if [[ -d "alacritty" ]]; then
    echo "- Updating repo..."
    cd alacritty
    git pull
  else
    echo "- Cloning the repo..."
    git clone https://github.com/alacritty/alacritty
    cd alacritty
  fi

  if ! command -v rustup &> /dev/null; then
    echo "- Installing rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup override set stable
    rustup update stable
  fi

  echo "- Installing requirements..."
  sudo apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

  echo "- Compiling and installing..."
  cargo build --release
  mkdir -p ~/.config/alacritty
  ln -sTf "$REPO_DIR/configs/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
  sudo ln -sTf "$REPO_DIR/compiled/alacritty/target/release/alacritty" /usr/local/bin/alacritty

  echo "- Copying .desktop file..."
  sudo cp desktop-entries/Alacritty.desktop /usr/share/applications
}

install_ranger() {
  if ! command -v ranger &> /dev/null; then
    echo "- Installing ranger..."
    sudo apt install ranger exiftool
  fi

  echo "- Linking configuration..."
  ln -sTf $REPO_DIR/configs/ranger ~/.config/ranger

  if [[ ! -e ~/.config/ranger/colorschemes/dracula.py ]]; then
    echo "- Installing colorscheme..."
    mkdir -p ~/.config/ranger/colorschemes
    git clone https://github.com/dracula/ranger.git /tmp/dracula
    mv /tmp/dracula/dracula.py ~/.config/ranger/colorschemes/
  fi

  if [[ ! -d ~/.config/ranger/plugins/ranger_devicons ]]; then
    echo "- Installing ranger devicons..."
    mkdir -p ~/.config/ranger/plugins
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
  fi
}

install_mpv() {
  if ! command -v mpv &> /dev/null; then
    echo "- Installing mpv..."
    sudo apt install mpv
  fi

  echo "- Linking configuration..."
  ln -sTf $REPO_DIR/configs/mpv ~/.config/mpv
}

install_zathura() {
  if ! command -v zathura &> /dev/null; then
    echo "- Installing zathura..."
    sudo apt install zathura
  fi

  echo "- Linking configuration..."
  ln -sTf $REPO_DIR/configs/zathura ~/.config/zathura
}

install_xournalpp() {
  if [[ -z "$(flatpak list | grep 'com.github.xournalpp.xournalpp')" ]]; then
    echo "Please install xournal++ before continuing (flatpak install com.github.xournalpp.xournalpp)..."
    read
  fi

  # For .deb package
  # CONFIG_PATH=~/.config/xournalpp
  # For flatpak package
  CONFIG_PATH=~/.var/app/com.github.xournalpp.xournalpp/config/xournalpp

  if [[ -d $CONFIG_PATH ]] && [[ ! -L $CONFIG_PATH ]]; then
    echo "- Do you want to remove Xournal++'s config folder?"
    echo "  ($CONFIG_PATH)"
    echo -n "  [s/N] > "
    read ANS
    if [[ "$ANS" != "s" ]] && [[ "$ANS" != "S" ]]; then
      echo "- The configuration was not installed!"
      exit 0
    fi
    echo "- Removing folder..."
    rm -rf "$CONFIG_PATH"
  fi

  echo "- Installing configuration..."
  ln -sTf "$REPO_DIR/configs/xournalpp" "$CONFIG_PATH"

  echo "- Now open xournalpp, close it, and change this file $CONFIG_PATH/settings.xml:"
  echo '  - Change the page template property to <property name="pageTemplate" value="xoj/template&#10;copyLastPageSize=false&#10;copyLastPageSettings=true&#10;size=595.275591x841.889764&#10;backgroundType=graph&#10;backgroundColor=#241f31&#10;"/>'
  echo '  - Change the toolbar layout to <property name="selectedToolbar" value="Minimal Top Copy"/>'
  echo '  - Change the stabilizer to <property name="stabilizerAveragingMethod" value="2"/>'
  echo '  - Change the stabilizer value to <property name="stabilizerSigma" value="0.9"/>'
  echo '  - Change the highlight position to <property name="highlightPosition" value="true"/>'
  echo '  - Change the highlight position radius to <property name="cursorHighlightRadius" value="5"/>'
  echo '  - Change this property to <property name="emptyLastPageAppend" value="onDrawOfLastPage"/>'
  echo '  - Change the background color to <property name="backgroundColor" value="4278190080"/>'
  echo '  - Change the active color to <property name="selectionBorderColor" value="4294901760"/>'
  echo '  - These are the most important setting. Customize the other options from the interface...'
}

# install_neovim
# install_zsh
# install_feh
# install_rofi
# install_dunst
# install_i3
# install_alacritty
# install_mpv
# install_ranger
# install_zathura
# install_xournalpp

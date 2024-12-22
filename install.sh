#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

echo "Adding nvim repository 📖"
sudo add-apt-repository ppa:neovim-ppa/unstable -y &>/dev/null
if [ $? -ne 0 ]; then echo "Failed to add nvim repository" && exit 1; fi

sudo apt update -y &>/dev/null
sudo apt upgrade -y &>/dev/null
if [ $? -ne 0 ]; then echo "Failed to update/upgrade the system" && exit 1; fi

echo "Installing packages 📦"
sudo apt install -y git zsh ripgrep xclip unzip make gcc fd-find neovim &>/dev/null
if [ $? -ne 0 ]; then echo "Failed to install packages" && exit 1; fi

echo "Install TMUX 🐧🐧🐧"
sudo killall -9 tmux || true
sudo apt -y remove tmux &>/dev/null
sudo apt -y install wget tar libevent-dev libncurses-dev &>/dev/null
if [ $? -ne 0 ]; then echo "Failed to install dependencies for tmux" && exit 1; fi

VERSION=3.5
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz &>/dev/null
if [ $? -ne 0 ]; then echo "Failed to download tmux source" && exit 1; fi

tar xf tmux-${VERSION}.tar.gz
rm -f tmux-${VERSION}.tar.gz
cd tmux-${VERSION}

./configure > configure.log 2>&1
if [ $? -ne 0 ]; then
    echo "TMUX configure failed, see configure.log for details"
    cat configure.log 
fi

make > make.log 2>&1
if [ $? -ne 0 ]; then
    echo "TMUX make failed, see make.log for details"
    cat make.log
fi

sudo make install > make_install.log 2>&1
if [ $? -ne 0 ]; then
    echo "TMUX make install failed, see make_install.log for details"
    cat make_install.log
fi
if [ $? -ne 0 ]; then echo "Failed to install tmux" && exit 1; fi

sudo rm configure.log make.log make_install.log
cd ..
sudo rm -rf /usr/local/src/tmux-*
sudo mv tmux-${VERSION} /usr/local/src


echo "Installing Lazygit 🔀"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*') &>/dev/null
if [ $? -ne 0 ]; then echo "Failed to fetch latest Lazygit version" && exit 1; fi

curl -Lo ~/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" &>/dev/null
if [ $? -ne 0 ]; then echo "Failed to download Lazygit" && exit 1; fi

tar xf ~/lazygit.tar.gz -C ~/
if [ $? -ne 0 ]; then echo "Failed to extract Lazygit" && exit 1; fi

sudo install ~/lazygit -D -t /usr/local/bin/
sudo rm -rf ~/lazygit ~/lazygit.tar.gz

echo "Stowing your config 🧹"
cd ~/.dotfiles/
stow lazygit || echo "Failed to stow lazygit"
stow nvim || echo "Failed to stow nvim"
stow zsh || echo "Failed to stow zsh"
stow tmux || echo "Failed to stow tmux"
stow oh-my-zsh || echo "Failed to stow oh-my-zsh"

echo "All done 👍"

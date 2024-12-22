echo "Adding nvim repository 📖"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update -y
sudo apt upgrade -y

echo "\nInstalling packages 📦"
sudo apt install -y git zsh ripgrep xclip unzip make gcc fd-find nvim

echo "\nInstall TMUX 🐧🐧🐧"
sudo killall -9 tmux
sudo apt -y remove tmux
sudo apt -y install wget tar libevent-dev libncurser-dev
VERSION=3.5
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
tar xf tmux-${VERSION}.tar.gz
rm -f tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure
make
sudo make install
cd -
sudo rm -rf /usr/local/src/tmux-\*
sudo mv tmux-${VERSION} /usr/local/src

echo "\nInstalling Lazygit 🔀"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo ~/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf ~/lazygit.tar.gz ~/lazygit
sudo install ~/lazygit -D -t /usr/local/bin/
sudo rm -rf ~/lazygit ~/lazygit.tar.gz

echo "\nStowing your config 🧹"
cd ~/.dotfiles/
stow lazygit
stow nvim
stow zsh
stow tmux
stow oh-my-zsh

echo "\nAll done 👍"

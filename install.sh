echo "Adding nvim repository"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update -y
sudo apt upgrade -y

echo "Installing packages"
# Install packages
sudo apt install -y git tmux zsh ripgrep xclip unzip make gcc fd-find nvim

# Install NVIM
#curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
#sudo rm -rf /opt/nvim
#sudo tar -C /opt -xzf nvim-linux64.tar.gz
#rm nvim-linux64.tar.gz

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo ~/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf ~/lazygit.tar.gz ~/lazygit
sudo install ~/lazygit -D -t /usr/local/bin/
rm -rf ~/lazygit ~/lazygit.tar.gz

echo "Stowing your config..."
cd ~/.dotfiles/
stow lazygit
stow nvim
stow zsh
stow tmux
stow oh-my-zsh

echo "All done 👍"

yay -S telegram-desktop lazygit wget git ripgrep htop docker docker-compose zsh postgresql redis tmux
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
asdf plugin-add python
asdf install python 3.8.5
asdf global python 3.8.5
git clone https://github.com:jlugao/dotfiles.git
cd dotfiles
ln -s -f /home/jlugao/dotfiles/.zshrc /home/jlugao/.zshrc
systemctl enable postgresql
systemctl enable redis

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

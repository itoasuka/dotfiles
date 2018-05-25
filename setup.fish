#!/usr/bin/fish

git submodule init
git submodule update

cd $HOME

mkdir -p $HOME/.config/fish
ln -sf $HOME/dotfiles/.config/fish/config.fish $HOME/.config/fish/config.fish

if test ! -e $HOME/.config/nvim 
  mkdir -p $HOME/.config/nvim
end
if test ! -e $HOME/.config/peco 
  mkdir -p $HOME/.config/peco
end
if test ! -e $HOME/.go/bin
  mkdir -p $HOME/.go/bin
end
if test `uname` = 'Darwin'
  ln -sf $HOME/dotfiles/.gitconfig_mac $HOME/.gitconfig
else
  ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
end
ln -sf $HOME/dotfiles/.gitignore $HOME/.gitignore
ln -sf $HOME/dotfiles/.vim $HOME/
ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -sf $HOME/dotfiles/.vimrc $HOME/.config/nvim/init.vim
ln -sf $HOME/dotfiles/.vim/after $HOME/.config/nvim/
ln -sf $HOME/dotfiles/.vim/dein.toml $HOME/.config/nvim/
ln -sf $HOME/dotfiles/.gvimrc $HOME/.gvimrc
ln -sf $HOME/dotfiles/.gvimrc $HOME/.config/nvim/ginit.vim
ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ls -sf $HOME/dotfiles/.config/peco/config.json $HOME/.config/peco/config.json

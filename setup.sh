#!/bin/sh

git submodule init
git submodule update

cd $HOME

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

if [ -e $HOME/.zshrc ]; then
  rm $HOME/.zshrc
fi
if [ ! -e $HOME/.config/nvim ]; then
  mkdir -p $HOME/.config/nvim
fi
ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/.zprofile $HOME/.zprofile
ln -sf $HOME/dotfiles/.zpreztorc $HOME/.zpreztorc
ls -sf "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin" $HOME/.zlogin
ls -sf "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogout" $HOME/.zlogout
ls -sf "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv" $HOME/.zshenv
if [ `uname` = 'Darwin' ]; then
  ln -sf $HOME/dotfiles/.gitconfig_mac $HOME/.gitconfig
else
  ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
fi
ln -sf $HOME/dotfiles/.gitignore $HOME/.gitignore
ln -sf $HOME/dotfiles/.vim $HOME/
ln -sf $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -sf $HOME/dotfiles/.vimrc $HOME/.config/nvim/init.vim
ln -sf $HOME/dotfiles/.vim/after $HOME/.config/nvim/
ln -sf $HOME/dotfiles/.vim/dein.toml $HOME/.config/nvim/
ln -sf $HOME/dotfiles/.gvimrc $HOME/.gvimrc
ln -sf $HOME/dotfiles/.gvimrc $HOME/.config/nvim/ginit.vim
ln -sf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/dotfiles/dircolors-solarized/dircolors.256dark $HOME/.dir_colors

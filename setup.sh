#!/bin/sh

git submodule init
git submodule update

cd $HOME

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

if [ -e $HOME/.zshrc ]; then
  rm $HOME/.zshrc
fi
if [ ! -e $HOME/.config ]; then
  mkdir $HOME/.config
fi
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.zprofile $HOME/.zprofile
ln -s $HOME/dotfiles/.zpreztorc $HOME/.zpreztorc
ls -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin" $HOME/.zlogin
ls -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogout" $HOME/.zlogout
ls -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv" $HOME/.zshenv
if [ `uname` == 'Darwin' ]; then
  ln -s $HOME/dotfiles/.gitconfig_mac $HOME/.gitconfig
else
  ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
fi
ln -s $HOME/dotfiles/.gitignore $HOME/.gitignore
ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.gvimrc $HOME/.gvimrc
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf


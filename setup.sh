#!/bin/sh

git submodule init
git submodule update

cd $HOME

#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

#if [ -e $HOME/.zshrc ]; then
#  rm $HOME/.zshrc
#fi
#ln -sf $HOME/dotfiles/.zshrc $HOME/.zshrc
#ln -sf $HOME/dotfiles/.zprofile $HOME/.zprofile
#ln -sf $HOME/dotfiles/.zpreztorc $HOME/.zpreztorc
#ls -sf "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin" $HOME/.zlogin
#ls -sf "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogout" $HOME/.zlogout
#ls -sf "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv" $HOME/.zshenv

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fisher install omf/theme-bobthefish
fiher install z
fisher install 0rax/fish-bd
fisher oh-my-fish/plugin-peco
mkdir -p $HOME/.config/fish
ln -sf $HOME/dotfiles/.config/fish/config.fish $HOME/.config/fish/config.fish

if [ ! -e $HOME/.config/nvim ]; then
  mkdir -p $HOME/.config/nvim
fi
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

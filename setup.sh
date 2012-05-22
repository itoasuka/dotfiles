#!/bin/sh

cd $HOME

wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

ln -s $HOME/dotfiles/.dircolors $HOME/.dircolors
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/.gitignore $HOME/.gitignore
ln -s $HOME/dotfiles/.gitmodules $HOME/.gitmodules
ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.git-completion.bash $HOME/.git-completion.bash

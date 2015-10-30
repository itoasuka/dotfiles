#!/bin/sh

git submodule init
git submodule update


cd $HOME

wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

if [ -e $HOME/.zshrc ]; then
  rm $HOME/.zshrc
fi
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
if [ `uname` == 'Darwin' ]; then
  ln -s $HOME/dotfiles/.gitconfig_mac $HOME/.gitconfig
else
  ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
fi
ln -s $HOME/dotfiles/.gitignore $HOME/.gitignore
ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.gvimrc $HOME/.gvimrc

mkdir -p $HOME/.zsh/completion/
cd $HOME/.zsh/completion/

wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh

mv git-completion.zsh _git
rm -f ~/.zcompdump
compinit

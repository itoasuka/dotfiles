# システム共通設定を読み込む
if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="steeef"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
\which gls . > /dev/null
if [ $? = 0 ]; then
  alias ls="gls"
fi

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
case ${OSTYPE} in
  darwin*)
    # ここに Mac 向けの設定
    plugins=(git brew osx gnu-utils vi-mode)
    ;;
  linux*)
    # ここに Linux 向けの設定
    plugins=(git gnu-utils vi-mode)
    ;;
esac

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# 環境依存ファイルがあれば読み込む
if [ -r $HOME/.profile ]; then
  source $HOME/.profile
fi

# キーマッピング
bindkey "^R" history-incremental-search-backward

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit -u

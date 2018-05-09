set fish_plugins theme peco

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

set -x EDITOR nvim
set -x GOPATH $HOME/.go

# 環境ごとの設定
switch (uname -s)
  case Darwin
    set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_162.jdk/Contents/Home
    set PATH $HOME/.nodebrew/current/bin $PATH
  case "*"
end

switch "$TERM"
  case linux
    set -x LANG en_US.UTF-8
  case "*"
    set -x LANG ja_JP.UTF-8
end

set PATH $GOPATH/bin $PATH

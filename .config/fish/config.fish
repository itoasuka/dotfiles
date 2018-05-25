# プラグインマネージャ fundle 導入
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin oh-my-fish/theme-bobthefish
fundle plugin fisherman/z
fundle plugin 0rax/fish-bd
fundle plugin oh-my-fish/plugin-peco
fundle plugin tuvistavie/fish-ssh-agent

fundle init

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

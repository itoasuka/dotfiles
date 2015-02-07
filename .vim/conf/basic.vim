set scrolloff=5                   " スクロール時の余白確保
set textwidth=0                   " 一行に長い文章を書いても自動折り返ししない
set nobackup                      " バックアップ取らない
set noswapfile                    " スワップファイル作らない
set noundofile                    " undoファイルを作らない
set autoread                      " 他で書き換えたら自動で読み直す
set hidden                        " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効

" マウスを使えるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

" OSのクリップボードを使用する
set clipboard+=unnamed
set clipboard=unnamed

if has('mac')
  " MacでAltキーをMetaキーとしてあつかう
  set macmeta
endif

" Ev/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

set helpfile=$VIMRUNTIME/doc/help.txt

" JavaScript として扱うファイルの追加
au BufRead,BufNewFile,BufReadPre .bowerrc set filetype=javascript
" vimにCoffeeScriptを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
" JST(JavaScriptテンプレート)
au BufRead,BufNewFile *.ejs.* set filetype=jst
au BufRead,BufNewFile *.ejs set filetype=jst

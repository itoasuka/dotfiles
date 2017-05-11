set encoding=utf-8
scriptencoding utf-8

let OSTYPE = system('uname')

if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"-------------------------------------------------------------------------------------------------
" □ Dein {{{
"-------------------------------------------------------------------------------------------------
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}
"-------------------------------------------------------------------------------------------------
" □ 基本設定 {{{
"-------------------------------------------------------------------------------------------------
set fileencoding=utf-8
set fileencodings=utf-8,cp932

syntax on

" 行番号を表示
set number
set numberwidth=3

" カーソル行をハイライト
set cursorline

set scrolloff=5                   " スクロール時の余白確保
set textwidth=0                   " 一行に長い文章を書いても自動折り返ししない
set nobackup                      " バックアップ取らない
set noswapfile                    " スワップファイル作らない
set noundofile                    " undoファイルを作らない
set autoread                      " 他で書き換えたら自動で読み直す
set hidden                        " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start    " バックスペースでなんでも消せるように
set formatoptions=lmoq            " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                      " ビープをならさない
set browsedir=buffer              " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]     " カーソルを行頭、行末で止まらないようにする
set showcmd                       " コマンドをステータス行に表示
set showmode                      " 現在のモードを表示
set viminfo='50,<1000,s100,\"50   " viminfoファイルの設定
"set ambiwidth=double              " 全角記号のずれ対応
set modeline                      " モードラインを有効にする
set laststatus=2                  " ステータス行は2行
set cmdheight=2                   " コマンド行は2行
let loaded_matchparen = 1

" マウスを使えるようにする
set mouse=a
set guioptions+=a

" OSのクリップボードを使用する
" Linux の場合 xsel コマンドをインストールし、パスを通すこと
set clipboard=unnamed,unnamedplus

" Ev/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

set helpfile=$VIMRUNTIME/doc/help.txt

" Sign のありなしでピクピク桁が動くのがいやなので Sign がなくともダミーサイン
" を入れて SignColumn を常に表示する。
function! ShowSignColumn()
  sign define dummy
  execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
endfunc
augroup MyAutoCmd
  autocmd FileType * call ShowSignColumn()
augroup End

function! s:set_python_path()
  let s:python_path = system('python -', 'import sys;sys.stdout.write(",".join(sys.path))')

  python <<EOT
import sys
import vim

python_paths = vim.eval('s:python_path').split(',')
for path in python_paths:
  if not path in sys.path:
    sys.path.insert(0, path)
EOT
endfunction
call s:set_python_path()

" カーソルキーが正しく動くようにする
if !has('gui_running')
  set notimeout
  set ttimeout
  set timeoutlen=100
endif

" タブやインデントのデフォルト挙動
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop<
set autoindent

" インサートモード時にカーソルを細くする
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
if OSTYPE == "Linux\n"
  " この設定は VTE 互換ターミナルでのみ動く
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
elseif OSTYPE == "Darwin\n"
  " この設定は iTerm2 でのみ動く
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ESCでIME OFF
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd!
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
  noremap <silent> <ESC> <ESC>:call system(g:imeoff)<CR>
endif
"}}}
"-------------------------------------------------------------------------------------------------

" vim:set foldmethod=marker:

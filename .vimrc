set encoding=utf-8
scriptencoding utf-8

" macvim-kaoriya では Python2 と Python3 が共存できず先勝ちなので Python3 を早々とロードする
if has('python3')
endif

" augroup リセット
augroup MyAutoCmd
  autocmd!
augroup END

let g:mapleader = ' '
"-------------------------------------------------------------------------------------------------
" □ 各パスの設定 {{{
"-------------------------------------------------------------------------------------------------
if has('nvim')
  let s:config_home = empty($XDG_CONFIG_HOME) ? expand($HOME . '/.config') : $XDG_CONFIG_HOME
  let s:vimdir = s:config_home . '/nvim'
else
  if has('win32') || has('win64')
    let s:vimdir = $HOME . '/vimfiles'
  else
    let s:vimdir = $HOME . '/.vim'
  endif
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand($HOME . '/.cache') : $XDG_CACHE_HOME
" }}}
"-------------------------------------------------------------------------------------------------
" □ dein の設定 {{{
"-------------------------------------------------------------------------------------------------
" dein 関連のパスを設定する
let s:dein_dir       = s:cache_home . '/dein'
let s:dein_github    = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = 'Shougo/dein.vim'
let s:dein_repo_dir  = s:dein_github . '/' . s:dein_repo_name
let s:toml_file      = s:vimdir . '/dein.toml'

" dein の自動インストール
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" Required:
if has('vim_starting')
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir
endif

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

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

set ambiwidth=double

" クリップボードを OS と共有
set clipboard=unnamed,unnamedplus

" カラースキームの設定
set background=dark
colorscheme hybrid
" カーソル行ハイライト
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

" タブやインデントのデフォルト挙動
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop<
set autoindent

" 編集中でも他のファイルを開けるようにする
set hidden
" バックアップファイルは作らない
set nobackup
" スワップファイルは作らない
set noswapfile
" undo ファイルは作らない
set noundofile
" 他で書き換えたら自動で読み直す
set autoread
" 自動的に折り返さない
set textwidth=0
" ステータスラインは常に表示
set laststatus=2
" コマンド行は2行
set cmdheight=2
" スクロール時の余白確保
set scrolloff=5

" 検索時に大文字小文字の区別なし
set ignorecase
" 検索時に大文字を含んでいたら大/小を区別
set smartcase
" 検索対象をハイライト
" ハイライトを消す場合は:noh[l]
set hlsearch

" ビープを鳴らさない
set visualbell t_vb=

if (exists('+colorcolumn'))
  " 1行が長くなりすぎないように目印をつける
  set colorcolumn=120
endif
" }}}
"-------------------------------------------------------------------------------------------------
" vim:set foldmethod=marker:

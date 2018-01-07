set encoding=utf-8

if &compatible
  set nocompatible               " Be iMproved
endif

"-------------------------------------------------------------------------------------------------
" □ 各パスの設定 {{{
"-------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
  let s:vimdir = $HOME . '/vimfiles'
else
  let s:vimdir = $HOME . '/.vim'
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
  let &runtimepath = &runtimepath . "," . s:dein_repo_dir
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
" クリップボードを OS と共有
set clipboard=unnamed,autoselect
" カラースキームの設定
set background=dark
colorscheme hybrid
" カーソル行ハイライト
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE
" }}}
"-------------------------------------------------------------------------------------------------
" vim:set foldmethod=marker:

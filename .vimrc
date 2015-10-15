set encoding=utf-8

"-----------------------------------------------------------------------------
" □ 基本設定 {{{
"-----------------------------------------------------------------------------
scriptencoding utf-8

set fileencoding=utf-8
set fileencodings=utf-8,cp932

syntax on

" 行番号を表示
set number

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
set ambiwidth=double              " 全角記号のずれ対応

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
"}}}
"-----------------------------------------------------------------------------
" □ NeoBundle の設定 {{{
"-----------------------------------------------------------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" 基本 {{{
" NeoBundle 自体を NeoBundle の管理下に置く
NeoBundleFetch 'Shougo/neobundle.vim'

" 非同期処理
NeoBundle 'Shougo/vimproc.vim', {
      \   'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin'  : 'make -f make_cygwin.mak',
      \     'mac'     : 'make',
      \     'linux'   : 'make',
      \     'unix'    : 'gmake',
      \   },
      \ }

" Shell
NeoBundle 'Shougo/vimshell.vim'

" かっこいいカラースキーム
NeoBundle 'w0ng/vim-hybrid'

" かっこいいステータスライン
NeoBundle 'itchyny/lightline.vim'

" 補完
NeoBundle 'Shougo/neocomplete.vim'

" Vimのリストをサクサク移動（実践Vim P.116）
" バッファ     前 [b 次 ]b 最初 [B 最後 ]B
" 引数リスト      [a    ]a
" Quickfix        [q    ]q
" ロケーション    [l    ]l
" タグリスト      [t    ]t
NeoBundle 'unimpaired.vim'
"}}}

call neobundle#end()

filetype plugin indent on 

NeoBundleCheck
"}}}
"-----------------------------------------------------------------------------
" □ カラースキームの設定 {{{
"-----------------------------------------------------------------------------
let g:hybrid_use_Xresources = 1
set background=dark
colorscheme hybrid
"}}}
"-----------------------------------------------------------------------------
" □ ステータスラインの設定 {{{
"-----------------------------------------------------------------------------
let g:lightline = {
      \   'colorscheme' : 'solarized_dark',
      \   'separator'   : { 'left': '⮀', 'right': '⮂' },
      \   'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
"}}}
"-----------------------------------------------------------------------------
" □ IME関連の設定 {{{
"-----------------------------------------------------------------------------
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
" ノーマルモードに戻ったときは IME を OFF にする
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
"}}}
"-----------------------------------------------------------------------------
" □ 補完関連の設定 {{{
"-----------------------------------------------------------------------------
set wildmenu            " コマンド補完を強化
set wildchar=<tab>      " コマンド補完を開始するキー
set wildmode=list:full  " リスト表示、最長マッチ
set history=1000        " コマンド・検索パターンの履歴数
set complete+=k         " 補完に辞書ファイル追加
"}}}
"-----------------------------------------------------------------------------
" □ NeoComplete の設定 {{{
"-----------------------------------------------------------------------------
" AutoComplPop を無効化
let g:acp_enableAtStartup = 0
" neocomplete を使う
let g:neocomplete#enable_at_startup = 1
" smartcase を使う
let g:neocomplete#enable_smart_case = 1
" 補完が有効になる文字数
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \  'default' : '',
      \  'vimshell' : $HOME.'/.vimshell_hist',
      \  'scheme' : $HOME.'/.gosh_completions'
      \ }

" ポップアップを Return で閉じる
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB> : 補完
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS> : ポップアップを閉じて後ろの文字を削除
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" <C-y> : ポップアップを閉じる
inoremap <expr><C-y> neocomplete#close_popup()
" <C-e> : ポップアップをキャンセルする
inoremap <expr><C-e> neocomplete#cancel_popup()
    
"}}}
"-----------------------------------------------------------------------------
" □ ファイルタイプ共通設定 {{{
"-----------------------------------------------------------------------------
autocmd FileType * setlocal formatoptions-=ro
"}}}
"-----------------------------------------------------------------------------
" □ Vim Script の設定 {{{
"-----------------------------------------------------------------------------
autocmd FileType vim setlocal sw=2 sts=2 ts=2 et
"}}}
"-----------------------------------------------------------------------------

" vim:set foldmethod=marker:


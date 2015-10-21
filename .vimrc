set encoding=utf-8

"-----------------------------------------------------------------------------
" □ 設定チートシート
"-----------------------------------------------------------------------------
" Unite 関連
" ,ub     バッファ一覧
" ,uf     ファイル一覧
" ,ur     レジスタ一覧
" ,um     最近使用したファイル一覧
" ,uu     バッファと最近使用したファイル一覧
" ,ua     バッファ、ファイル、最近使用したファイル、ブックマーク一覧
" Split 関連
" [s      左スプリットへ
" ]s      右スプリットへ
" JavaScript 関連
" <C-l>   JsDoc 追加
"-----------------------------------------------------------------------------
" □ 基本設定 {{{
"-----------------------------------------------------------------------------
scriptencoding utf-8

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

" Sign のありなしでピクピク桁が動くのがいやなので Sing がなくともダミーサイン
" を入れて SignColumn を常に表示する。
function! ShowSignColumn()
  sign define dummy
  execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
endfunc
autocmd FileType vim call ShowSignColumn()
autocmd FileType javascript call ShowSignColumn()
"}}}
"-----------------------------------------------------------------------------
" □ 検索関連の設定 {{{
"-----------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
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

" 最近使ったファイル記録
NeoBundle 'Shougo/neomru.vim'
"}}}
" ファイル管理 {{{
" Git 操作
NeoBundle 'tpope/vim-fugitive'
" Git 差分表示
NeoBundle 'airblade/vim-gitgutter'
" ファイラ
NeoBundle 'Shougo/vimfiler.vim'
"}}}
" Unite {{{
NeoBundle 'Shougo/unite.vim'
" }}}
" コーディング関連 {{{
NeoBundle 'scrooloose/syntastic.git'
"}}}
" JavaScript {{{
" JavaScript 用インデント
NeoBundleLazy 'pangloss/vim-javascript', {'autoload':{'filetypes':['javascript']}}
" JavaScript のシンタックスハイライトをより素敵に
" ※yajs.vimでことたりそうなのでいまのところコメントアウト
"NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
" JSX 対応シンタックスハイライト
NeoBundleLazy 'mxw/vim-jsx', {'autoload':{'filetypes':['javascript']}}
" ES6 対応シンタックスハイライト
NeoBundleLazy 'othree/yajs.vim', {'autoload':{'filetypes':['javascript']}}
" JavaScript の補完  
NeoBundleLazy 'marijnh/tern_for_vim', {
      \   'build': {
      \     'others': 'npm install'
      \   },
      \   'autoload': {'filetypes': ['javascript']}
      \ }
" JSON の扱いを素敵に
NeoBundleLazy 'elzr/vim-json', {'autoload':{'filetypes':['json']}}
" JsDoc の入力を楽にする
NeoBundleLazy 'heavenshell/vim-jsdoc', {'autoload':{'filetypes':['javascript']}}
" Node 用辞書
NeoBundle 'guileen/vim-node-dict'
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
      \   'colorscheme' : 'jellybeans',
      \   'mode_map': {'c': 'NORMAL'},
      \   'active': {
      \     'left': [
      \       ['mode', 'paste'],
      \       ['fugitive', 'gitgutter', 'filename'],
      \     ]
      \   },
      \   'component_function': {
      \     'modified' : 'MyModified',
      \     'readonly' : 'MyReadonly',
      \     'fugitive' : 'MyFugitive',
      \     'gitgutter': 'MyGitGutter',
      \     'filename' : 'MyFilename'
      \   },
      \   'separator'   : { 'left': '⮀', 'right': '⮂' },
      \   'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added,
        \ g:gitgutter_sign_modified,
        \ g:gitgutter_sign_removed
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:p') ? expand('%:p') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
"}}}
"-----------------------------------------------------------------------------
" □ gitgutter の設定 {{{
"-----------------------------------------------------------------------------
" vim-gitgutter
let g:gitgutter_sign_added = '＋'
let g:gitgutter_sign_modified = '→'
let g:gitgutter_sign_removed = '×'
"}}}
"-----------------------------------------------------------------------------
" □ VimFiler の設定 {{{
"-----------------------------------------------------------------------------
let g:vimfiler_as_default_explorer = 1
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
" □ Unite の設定 {{{
"-----------------------------------------------------------------------------
"let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ESCキーを2回押すと終了する
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q
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
" プレビューウィンドウを自動で閉じる
let g:neocomplete#enable_auto_close_preview = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \  'default' : '',
      \  'vimshell' : $HOME.'/.vimshell_hist',
      \  'scheme' : $HOME.'/.gosh_completions',
      \  'javascript': $HOME.'/.vim/bundle/vim-node-dict/dict/node.dict'
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
" □ syntastic の設定 {{{
"-----------------------------------------------------------------------------
" ファイルを開いた時にシンタックスチェックをしない
let g:syntastic_check_on_open = 0
" ファイルを保存した時にシンタックスチェックをする
let g:syntastic_check_on_save = 1
" TypeScript のシンタックスチェッカを指定
let g:syntastic_typescript_checkers = ['tsc']
" JavaScript のシンタックスチェッカを指定
let g:syntastic_javascript_checkers = ['eslint']
" シンタックスチェッカを利用するファイルタイプを指定
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['javascript', 'javascript.jsx', 'typescript'],
      \ 'passive_filetypes': []
      \ }
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='×'
let g:syntastic_warning_symbol='！'
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
" □ VimShell の設定 {{{
"-----------------------------------------------------------------------------
" 行番号は表示しない
autocmd FileType vimshell setlocal nonumber
"}}}
"-----------------------------------------------------------------------------
" □ Windows バッチファイルの設定 {{{
"-----------------------------------------------------------------------------
autocmd FileType dosbatch :set fileencoding=cp932
autocmd FileType dosbatch :set fileformat=dos
autocmd FileType dosbatch setlocal sw=4 sts=4 ts=4 et
"}}}
"-----------------------------------------------------------------------------
" □ JavaScript の設定"{{{
"-----------------------------------------------------------------------------
" vim-json のダブルクォートを隠す機能は不要
let s:bundle = neobundle#get('vim-json')
function! s:bundle.hooks.on_source(bundle)
  let g:vim_json_syntax_conceal = 0
endfunction
unlet s:bundle

autocmd BufRead,BufNewFile,BufReadPre .eslintrc set filetype=json

autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
autocmd FileType jsx        setlocal sw=2 sts=2 ts=2 et
autocmd FileType json       setlocal sw=2 sts=2 ts=2 et

let s:bundle = neobundle#get('vim-jsdoc')
function! s:bundle.hooks.on_source(bundle)
  nmap <silent> <C-l> <Plug>(jsdoc)
endfunction
unlet s:bundle

" Node 用辞書を追加する
autocmd FileType javascript setlocal dictionary+=$HOME/.vim/bundle/vim-node-dict/dict/node.dict
"}}}
"-----------------------------------------------------------------------------
" □ その他のキーマップ {{{
"-----------------------------------------------------------------------------
" アクティブなファイルが含まれているディレクトリを素早く展開する
" (本来 %:h とするところを %% と書けるようにする)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'
nnoremap [s <C-w>h
nnoremap ]s <C-w>l
"}}}
"-----------------------------------------------------------------------------

" vim:set foldmethod=marker:


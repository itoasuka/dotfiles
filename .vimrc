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
" □ NeoBundle の設定 {{{
"-----------------------------------------------------------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  if has('win32') || has('win64')
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
endif

if has('win32') || has('win64')
  call neobundle#begin(expand('~/vimfiles/bundle/'))
else
  call neobundle#begin(expand('~/.vim/bundle/'))
endif
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
if has('nvim') || v:version > 703
  NeoBundleLazy 'Shougo/vimshell.vim', {
    \ 'depends' : 'Shougo/vimproc.vim',
    \ 'autoload' : {
    \   'commands' : [{ 'name' : 'VimShell',
    \                   'complete' : 'customlist,vimshell#complete'},
    \                   'VimShellExecute', 'VimShellInteractive',
    \                   'VimShellTerminal', 'VimShellPop'],
    \   'mappings' : ['<Plug>(vimshell_']
    \ }
    \}
endif

" かっこいいカラースキーム
NeoBundle 'w0ng/vim-hybrid'

" かっこいいステータスライン
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'Shougo/neoinclude.vim'

" 補完
if has('nvim')
  NeoBundle 'Shougo/deoplete.nvim'
elseif has('lua') && (v:version > 703 || v:version == 703 && has('patch885'))
  NeoBundle 'Shougo/neocomplete.vim'
endif

" Vimのリストをサクサク移動（実践Vim P.116）
" バッファ     前 [b 次 ]b 最初 [B 最後 ]B
" 引数リスト      [a    ]a
" Quickfix        [q    ]q
" ロケーション    [l    ]l
" タグリスト      [t    ]t
NeoBundle 'unimpaired.vim'

" 最近使ったファイル記録
NeoBundle 'Shougo/neomru.vim'

" sudo
NeoBundle "sudo.vim"

" Project
NeoBundleLazy "shemerey/vim-project", {'commands':['Project']}

" ディレクトリごとの設定ができるやつ
NeoBundle 'thinca/vim-localrc'
"}}}
" ファイル管理 {{{
if executable('git')
  " Git 操作
  NeoBundle 'tpope/vim-fugitive'
  " Git 差分表示
  NeoBundle 'airblade/vim-gitgutter'
endif
" ファイラ
if has('nvim') || v:version > 703
  NeoBundleLazy 'Shougo/vimfiler.vim', {'autoload':{'commands':['VimFiler', 'VimFilerBufferDir']}}
endif
"}}}
" Unite {{{
if has('nvim') || v:version > 703
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'tsukkee/unite-tag'
endif
" }}}
" コーディング関連 {{{
NeoBundle 'scrooloose/syntastic.git'

if executable('ctags')
  " ctagsを使うのを楽にするやつ
  NeoBundle 'soramugi/auto-ctags.vim'
  " タグリストを出すやつ
  NeoBundle 'majutsushi/tagbar'
endif

NeoBundle 'nathanaelkane/vim-indent-guides'
"}}}
" JavaScript {{{
" JavaScript 用インデント
" ※NeoBundleLazyだとvim-jsxが上手く動かないっぽい
NeoBundle 'pangloss/vim-javascript'
" JavaScript のシンタックスハイライトをより素敵に
" ※yajs.vimでことたりそうなのでいまのところコメントアウト
"NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
" JSX 対応シンタックスハイライト
NeoBundleLazy 'mxw/vim-jsx', {'depends':['pangloss/vim-javascript'], 'autoload':{'filetypes':['jsx']}}
" ES6 対応シンタックスハイライト
NeoBundleLazy 'othree/yajs.vim', {'autoload':{'filetypes':['javascript']}}
" JavaScript の補完  
if executable("npm") 
  " npm が使える環境にのみインストールする
  NeoBundleLazy 'marijnh/tern_for_vim', {
        \   'build': {
        \     'others': 'npm install'
        \   },
        \   'autoload': {'filetypes': ['javascript']}
        \ }
endif
" JSON の扱いを素敵に
NeoBundleLazy 'elzr/vim-json', {'autoload':{'filetypes':['json']}}
" JsDoc の入力を楽にする
NeoBundleLazy 'heavenshell/vim-jsdoc', {'autoload':{'filetypes':['javascript']}}
" Node 用辞書
NeoBundleLazy 'guileen/vim-node-dict', {'autoload':{'filetypes':['javascript']}}
"}}}
" Scala {{{
" シンタックスハイライト
NeoBundleLazy 'derekwyatt/vim-scala', {'autoload':{'filetypes':['scala', 'html', 'play2-conf', 'play2-routes']}}
" Play Framework 用シンタックスハイライト 
" ※NeoBundleLazyだとちゃんと動かないっぽい
NeoBundle 'gre/play2vim'
" SBT 対応 
NeoBundleLazy 'ktvoelker/sbt-vim',  {'autoload':{'filetypes':['sbt']}}
NeoBundleLazy 'ensime/ensime-vim',  {'autoload':{'filetypes':['scala']}}
"}}}
" VisualBasic(!) {{{
NeoBundleLazy 'yukpiz/vim-vbnet', {"autoload" : { "filetypes" : ["vbnet"], }}
" }}}
" Haskell {{{
NeoBundleLazy 'neovimhaskell/haskell-vim', {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy 'eagletmt/neco-ghc', {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy 'eagletmt/ghcmod-vim', {"autoload" : { "filetypes" : ["haskell"] }}
" }}}
" DB {{{
NeoBundle 'vim-scripts/dbext.vim'
" }}}
" その他 {{{
" Scala IDEがまともに扱えないのでコメントアウト
"if executable("ant")
  " EclipseをVimからこき使う
"  NeoBundle 'ervandew/eclim.git', {
"        \   "build": {
"        \     "other": "ant"
"        \   }
"        \ }
"endif
" Re:VIEW 用コードハイライト（使うかな？）
NeoBundleLazy 'moro/vim-review', {'autoload':{'filetype':['review']}}
" Markdown
NeoBundleLazy 'plasticboy/vim-markdown',  {'autoload':{'filetypes':['markdown']}}
" blockdiag
NeoBundle 'aohta/blockdiag.vim'
"}}}

call neobundle#end()

filetype plugin indent on 

NeoBundleCheck
"}}}
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
if v:version > 702
  set noundofile                    " undoファイルを作らない
endif
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
set modeline                      " モードラインを有効にする
set laststatus=2                  " ステータス行は2行
set cmdheight=2                   " コマンド行は2行

" マウスを使えるようにする
set mouse=a
set guioptions+=a
if !has('nvim')
  set ttymouse=xterm2
endif

" OSのクリップボードを使用する
set clipboard+=unnamed
if !has('nvim')
  set clipboard+=autoselect
endif

if has('mac') && !has('nvim')
  " MacでAltキーをMetaキーとしてあつかう
  set macmeta
endif

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
autocmd FileType vim call ShowSignColumn()
autocmd FileType javascript call ShowSignColumn()

if has('python')
  " Python 環境が思ってたんのと違う場合の対応
  " 参考 http://qiita.com/tmsanrinsha/items/cfa3808b8d0cc915cd75
  if has('kaoriya') && has('mac')
    " 特にKaoriYa パッチの MacVim で起こる
    " この辺も参照→ http://goo.gl/OS772W
    if filereadable('/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/Python')
      let $PYTHON_DLL = "/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/Python"
    endif
  endif
endif

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

if has('nvim')
  call s:set_python_path()
endif

" カーソルキーが正しく動くようにする
if !has('gui_running')
  set notimeout
  set ttimeout
  set timeoutlen=100
endif

" タブやインデントのデフォルト挙動
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop<
set autoindent
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
      \     'modified'  : 'MyModified',
      \     'readonly'  : 'MyReadonly',
      \     'fugitive'  : 'MyFugitive',
      \     'gitgutter' : 'MyGitGutter',
      \     'filename'  : 'MyFilename'
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
    if executable('git')
      if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        let _ = fugitive#head()
        return strlen(_) ? '⭠ '._ : ''
      endif
    end
  catch
  endtry
  return ''
endfunction

function! MyGitGutter()
  if executable('git')
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
  else
    return ''
  endif
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
"}}}
"-----------------------------------------------------------------------------
" □ indent-guides の設定 {{{
"-----------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
" }}}
"-----------------------------------------------------------------------------
" □ Project の設定 {{{
"-----------------------------------------------------------------------------
let s:bundle = neobundle#get('vim-project')
function! s:bundle.hooks.on_source(bundle)
  " ファイルが選択されたらウィンドウを閉じる
  let g:proj_flags = 'imtc'
  " <Leader>Pでプロジェクトをトグル開閉する
  nmap <silent> <Leader>P <Plug>ToggleProject
  " <Leader>pでデフォルトのプロジェクトを開く
  nmap <silent> <Leader>p :Project<CR>
endfunction
"}}}
"-----------------------------------------------------------------------------
" □ gitgutter の設定 {{{
"-----------------------------------------------------------------------------
" vim-gitgutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '->'
let g:gitgutter_sign_removed = 'X'
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
"}}}
"-----------------------------------------------------------------------------
" □ Unite の設定 {{{
"-----------------------------------------------------------------------------
if has('nvim') || v:version > 703
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
endif
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
" □ NeoComplete / deoplete の設定 {{{
"-----------------------------------------------------------------------------
" AutoComplPop を無効化
let g:acp_enableAtStartup = 0
if has('nvim')
  " deoplete を使う
  let g:deoplete#enable_at_startup = 1
  " smartcase を使う
  let g:deoplete#enable_smart_case = 1
  " 補完が有効になる文字数
  let g:deoplete#auto_completion_start_length = 3

  " <TAB> : 補完
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
elseif has('lua') && (v:version > 703 || v:version == 703 && has('patch885'))
  " neocomplete を使う
  let g:neocomplete#enable_at_startup = 1
  " smartcase を使う
  let g:neocomplete#enable_smart_case = 1
  " 補完が有効になる文字数
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " プレビューウィンドウを自動で閉じる
  let g:neocomplete#enable_auto_close_preview = 1


  " ポップアップを Return で閉じる
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction

  let g:neocomplete#sources#dictionary#dictionaries = {
    \   'default' : '',
    \   'vimshell' : $HOME.'/.vimshell_hist',
    \   'javascript': $HOME.'/.vimrc/bundle/vim-node-dict/dict/node.dict',
    \   'scala': $HOME.'/.vimrc/dict/scala.dict'
    \ }

  " <TAB> : 補完
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS> : ポップアップを閉じて後ろの文字を削除
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " <C-y> : ポップアップを閉じる
  inoremap <expr><C-y> neocomplete#close_popup()
  " <C-e> : ポップアップをキャンセルする
  inoremap <expr><C-e> neocomplete#cancel_popup()

  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
endif
    
"}}}
"-----------------------------------------------------------------------------
" □ ファイルタイプ共通設定 {{{
"-----------------------------------------------------------------------------
autocmd FileType * setlocal formatoptions-=ro
"}}}
"-----------------------------------------------------------------------------
" □ tags 関連 {{{
"-----------------------------------------------------------------------------
" タグバーのトグル
if executable('ctags')
  nmap <F8> :TagbarToggle<CR>
endif
if has('nvim') || v:version > 703
  " Unite-tag でタグジャンプ
  autocmd BufEnter *
        \   if empty(&buftype)
        \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
        \|  endif
  " Unite-tag でのタグジャンプの戻り
  autocmd BufEnter *
        \   if empty(&buftype)
        \|      nnoremap <buffer> <C-t> :<C-u>Unite jump<CR>
        \|  endif
endif
" }}}
"-----------------------------------------------------------------------------
" □ Syntastic の設定 {{{
"-----------------------------------------------------------------------------
let g:syntastic_javascript_checkers=['eslint']
"}}}
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
" □ Vim Script の設定 {{{
"-----------------------------------------------------------------------------
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
" □ JavaScript の設定 {{{
"-----------------------------------------------------------------------------
" vim-json のダブルクォートを隠す機能は不要
let s:bundle = neobundle#get('vim-json')
function! s:bundle.hooks.on_source(bundle)
  let g:vim_json_syntax_conceal = 0
endfunction
unlet s:bundle

let s:bundle = neobundle#get('vim-jsdoc')
function! s:bundle.hooks.on_source(bundle)
  nmap <silent> <C-l> <Plug>(jsdoc)
endfunction
unlet s:bundle
"}}}
"-----------------------------------------------------------------------------
" □ Scala の設定 {{{
"-----------------------------------------------------------------------------
if has('python') || has('nvim')
  " ※ensime-vimはpythonが有効な場合のみインストールされている
  let s:bundle = neobundle#get('ensime-vim')
  function! s:bundle.hooks.on_source(bundle)
    if has('kaoriya') && has('mac')
      call s:set_python_path()
    endif
  endfunction
  unlet s:bundle

  if has('nvim')
    if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
    endif
    let g:deoplete#omni#input_patterns.scala= '\k\.\k*'
  else
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.scala = '\k\.\k*'
  endif
  set completeopt-=preview
endif
"}}}
"-----------------------------------------------------------------------------
" □ データベース関連の設定 {{{
"-----------------------------------------------------------------------------
let g:dbext_default_profile_obane = 'type=PGSQL:user=obane:passwd=obane:dbname=obane'
" }}}
"-----------------------------------------------------------------------------
" □ その他のキーマップ {{{
"-----------------------------------------------------------------------------
" アクティブなファイルが含まれているディレクトリを素早く展開する
" (本来 %:h とするところを %% と書けるようにする)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'
nnoremap [s <C-w>h
nnoremap ]s <C-w>l
map \ <Leader>
"}}}
"-----------------------------------------------------------------------------

" vim:set foldmethod=marker:


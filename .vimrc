set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'unimpaired.vim'
NeoBundle 'surround.vim'
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'Shougo/unite.vim'
" マニュアル参照
NeoBundle 'thinca/vim-ref'
" 強力なコメントアウト
NeoBundle 'The-NERD-Commenter'
" quickfix を見てハイライトするプラグイン
NeoBundle "jceb/vim-hier"
" QuickRun
NeoBundle "thinca/vim-quickrun"
" 非同期でプロセスを動かす
NeoBundle "Shougo/vimproc"
" quickrun-hook 集
NeoBundle "osyo-manga/shabadou.vim"
" いろいろな言語に対応したシンタックスチェック
NeoBundle "osyo-manga/vim-watchdogs"
" CoffeeScript の syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
" JavaScript テンプレート ejs 用
NeoBundle 'jeyb/vim-jst'
" インデントの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'
" かっこいいカラースキーム
NeoBundle 'altercation/vim-colors-solarized'
" 自動補完
NeoBundle 'Shougo/neocomplcache'
" ローカル設定読み込み
NeoBundle 'thinca/vim-localrc'
" Scala 対応
NeoBundle 'derekwyatt/vim-scala'
" Haskell 対応
NeoBundle 'kana/vim-filetype-haskell' " シンタックスハイライト
NeoBundle 'eagletmt/ghcmod-vim'       " 型の表示
NeoBundle 'ujihisa/neco-ghc'          " 補完
NeoBundle 'pbrisbin/html-template-syntax'
NeoBundle 'ujihisa/ref-hoogle'        " hoogle 参照
NeoBundle 'ujihisa/unite-haskellimport'
" Pukiwiki
NeoBundle 'syngan/vim-pukiwiki'

runtime macros/matchit.vim

" ファイルタイプ判定をon
filetype plugin indent on

" マウスを使えるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

" OSのクリップボードを使用する
set clipboard+=unnamed
set clipboard=unnamed

set nobackup                     " バックアップ取らない
set noswapfile                   " スワップファイル作らない

"-------------------------------------------------------------------------------
" 表示関連
"-------------------------------------------------------------------------------
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示
set list              " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< 
                      " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
set cursorline        " カーソル行に下線を引く


"-------------------------------------------------------------------------------
" ステータスライン
"-------------------------------------------------------------------------------
set laststatus=2 " 常にステータスラインを表示

"カーソルが何行目の何列目に置かれているかを表示する
set ruler

"----
"ステータスラインに文字コードと改行文字を表示する
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc
"----




"-------------------------------------------------------------------------------
" インデント Indent
"-------------------------------------------------------------------------------
set autoindent   " 自動インデント
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab    " ソフトタブを使う


"-------------------------------------------------------------------------------
" 履歴
"-------------------------------------------------------------------------------
set history=200

"-------------------------------------------------------------------------------
" バッファ切り替え関連
"-------------------------------------------------------------------------------
"変更中のファイルでも、保存しないでバッファ切り替えできるようにする
set hidden

"-------------------------------------------------------------------------------
" Key Map
"-------------------------------------------------------------------------------
" アクティブなファイルが含まれているディレクトリを素早く展開する
" (本来 %:h とするところを %% と書けるようにする)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'

" Vim 練習用
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


"-------------------------------------------------------------------------------
" indent_guides
"-------------------------------------------------------------------------------
" インデントの深さに色を付ける
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0

augroup indentguides
    autocmd!
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
augroup END

"-------------------------------------------------------------------------------
" neocomplcache
"-------------------------------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"-------------------------------------------------------------------------------
" 外部設定の読み込み
"-------------------------------------------------------------------------------
source ~/.vim/conf/quickrun.vim
source ~/.vim/conf/project.vim
source ~/.vim/conf/js.vim
source ~/.vim/conf/coffee.vim
source ~/.vim/conf/jst.vim
source ~/.vim/conf/comment.vim
source ~/.vim/conf/watchdogs.vim
source ~/.vim/conf/pukiwiki.vim

"-------------------------------------------------------------------------------
" その他
"-------------------------------------------------------------------------------
" 改行時に自動的にコメントが入るのをやめる
autocmd Filetype * set formatoptions-=ro

" カラー設定
if !has('gui_running')
    syntax enable
    set background=dark
    colorscheme solarized
endif

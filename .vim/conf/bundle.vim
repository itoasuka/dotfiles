" NeoBundle でプラギン管理

filetype off

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

" NeoBundle 自身を NeoBundle の管理対象下に置く
NeoBundleFetch 'Shougo/neobundle.vim'

" Edit {{{
  " 強力なコメント処理
  NeoBundle 'scrooloose/nerdcommenter.git'

  " インデントの深さに色を付ける
  NeoBundle 'nathanaelkane/vim-indent-guides'

  " スマートに括弧で囲む、削除する
  NeoBundle 'tpope/vim-surround'

  " 簡単に operator を定義できるようにする
  NeoBundle 'operator-user'

  " ヤンクしたものでリプレースする
  NeoBundle 'operator-replace'

  " Vimのリストをサクサク移動（実践Vim P.116）
  " バッファ     前 [b 次 ]b 最初 [B 最後 ]B
  " 引数リスト      [a    ]a
  " Quickfix        [q    ]q
  " ロケーション    [l    ]l
  " タグリスト      [t    ]t
  NeoBundle 'unimpaired.vim'

  " キャメルケースを意識した移動 ,w ,b
  NeoBundle 'bkad/CamelCaseMotion'

  " PHP 用ナイスなインデンター
  " NeoBundle 'php.vim-html-enhanced' " オリジナル
  " CakePHP を念頭にカスタマイズされた版
  NeoBundleLazy 'comeonly/php.vim-html-enhanced', {
        \'autoload': {'filetypes': ['php']}
        \}
  " JavaScript インデント
  NeoBundleLazy 'pangloss/vim-javascript', {
        \'autoload': {'filetypes': ['javascript']}
        \}

  " さらに JSX(React) 対応
  NeoBundleLazy 'mxw/vim-jsx', {
        \'autoload': {'filetypes': ['javascript']}
        \}

  " Haskell インデント
  NeoBundleLazy 'kana/vim-filetype-haskell', {
        \'autoload': {'filetypes': ['haskell']}
        \}

  " emmet-vim (HTML入力を高速化）
  NeoBundleLazy 'mattn/emmet-vim', {
        \'autoload': {'filetypes': ['html']}
        \}

  " eskk
  NeoBundle 'tyru/eskk.vim'

  " スニペット
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
" }}}

" Completion {{{
  " 自動補完
  if has('lua') && (v:version > 703 || v:version == 703 && has('patch885'))
    NeoBundle 'Shougo/neocomplete.vim'
  endif

  " GHC を用いた Haskell 用補完
  NeoBundleLazy 'ujihisa/neco-ghc', {
        \'autoload': {'filetypes': ['haskell']}
        \}
" }}}

" Seearching/Moving {{{
  " マーク位置表示
  " NeoBundle "ShowMarks"
  
  " 「%」による対応括弧へのカーソル移動機能を拡張
  " runtime macros/matchit.vim
" }}}

" Programming {{{
  " QuickRun : 編集中のファイルを簡単に実行できるプラギン
  NeoBundle "thinca/vim-quickrun"

  " Quckrun フック集
  NeoBundle "osyo-manga/shabadou.vim"

  " マニュアル参照
  NeoBundle 'thinca/vim-ref'
  
  " Hoogle 参照
  NeoBundleLazy 'ujihisa/ref-hoogle', {
        \'autoload': {'filetypes': ['haskell']}
        \}

  " SQLUtilities : SQL整形、生成ユーティリティ
  NeoBundleLazy 'SQLUtilities', {
        \'autoload': {'filetypes': ['sql']}
        \}

  " Tagbar
  NeoBundle 'majutsushi/tagbar'
  
  " Tagbar PHP
  NeoBundleLazy 'vim-scripts/tagbar-phpctags', {
        \'build' : {
        \ 'others' : 'chmod +x bin/phpctags',
        \ },
        \'autoload': {'filetypes': ['php']}
        \}

  " Tagbar Haskell
  NeoBundleLazy 'bitc/lushtags', {
        \'build' : {
        \ 'others' : 'cabal configure && cabal build && cabal install',
        \ },
        \'autoload': {'filetypes': ['haskell']}
        \}

  " GHC を用いた Haskell の型表示
  NeoBundle 'eagletmt/ghcmod-vim'
" }}}

" Syntax {{{
  " CoffeeScript の syntax + 自動compile
  NeoBundleLazy 'kchmck/vim-coffee-script', {
        \'autoload': {'filetypes': ['coffee']}
        \}

  " JavaScript テンプレート ejs 用
  NeoBundle 'jeyb/vim-jst'

  " JavaScript シンタックスハイライト
  NeoBundleLazy 'JavaScript-syntax', {
        \'autoload': {'filetypes': ['javascript']}
        \}

  " Node の require を理解してファイルを開く
  NeoBundleLazy 'moll/vim-node', {
        \'autoload': {'filetypes': ['javascript', 'coffee']}
        \}

  " Scala
  NeoBundleLazy 'derekwyatt/vim-scala', {
        \'autoload': {'filetypes': ['scala']}
        \}

  " Haskell
  NeoBundleLazy 'dag/vim2hs', {
        \'autoload': {'filetypes': ['haskell']}
        \}

  " Hakell HTML テンプレート
  NeoBundle 'pbrisbin/html-template-syntax'

  " TypeScript
  "
  " npm install -g typescript-tools しておいて
  " :TSSstarthere TypeScript Tools 起動
  " :TSSreload    ts ファイル読み込みなおし
  " CTRL-x+CTRL-oを押せば補完が効く
  NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
  NeoBundle 'https://github.com/clausreinke/typescript-tools.git'

  " シンタックスチェッカ
  NeoBundle 'scrooloose/syntastic'
  " NeoBundle "osyo-manga/vim-watchdogs"

  " Quckfix を見てエラー部分をハイライト
  NeoBundle "jceb/vim-hier"

  " JavaScript の補完サーバを利用するもの
  NeoBundleLazy 'marijnh/tern_for_vim', {
        \'autoload': {'filetypes': ['javascript', 'coffee']},
        \'build': { 'others': 'npm install' }
        \ }

  " Jade
  NeoBundleLazy 'digitaltoad/vim-jade', {
        \'autoload': {'filetypes': ['jade']},
        \ }

  " blockdiag
  NeoBundle 'aohta/blockdiag.vim'

  " Markdown
  NeoBundle 'plasticboy/vim-markdown'

  " Java
  NeoBundleLazy 'ervandew/eclim', {
        \'autoload': {'filetypes': ['java']},
        \'build': {'others': 'ant'}
        \ }
" }}}

" Encording {{{
  NeoBundle 'banyan/recognize_charcode.vim'
" }}}

" Utility {{{
  " ディレクトリおよびファイルのツリー表示
  NeoBundle 'scrooloose/nerdtree'

  " Vim の Shell
  NeoBundle "Shougo/vimshell"

  " vimproc : vimから非同期実行。vimshelleで必要
  NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

  " ステータスラインをカッコよくする
  NeoBundle 'itchyny/lightline.vim'

  " ローカル設定読み込み
  NeoBundle 'thinca/vim-localrc'

  " Pukiwiki
  NeoBundle 'syngan/vim-pukiwiki'

  " sudo
  NeoBundle 'sudo.vim'

  " ファイラ
  NeoBundle 'Shougo/vimfiler'
" }}}

" ColorSchema {{{
  " かっこいいカラースキーム
  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'chriskempson/vim-tomorrow-theme'
" }}}

" Unite {{{
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'tsukkee/unite-help'
  "NeoBundle 'h1mesuke/unite-outline'
  NeoBundle 'thinca/vim-unite-history'
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'Shougo/neomru.vim'

  " Haskell のインポート
  NeoBundle 'ujihisa/unite-haskellimport'
" }}}

call neobundle#end()

" ファイルタイプ判定をon
filetype plugin indent on

" 各プラグインのインストール状態チェック
NeoBundleCheck

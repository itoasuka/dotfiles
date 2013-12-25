" NeoBundle でプラギン管理

filetype off

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle'))

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
  NeoBundle 'comeonly/php.vim-html-enhanced' " CakePHP を念頭にカスタマイズされた版

  " JavaScript インデント
  NeoBundle 'pangloss/vim-javascript'

  " Haskell インデント
  NeoBundle 'kana/vim-filetype-haskell'

" }}}

" Completion {{{
  " 自動補完
  NeoBundle 'Shougo/neocomplete.vim'

  " GHC を用いた Haskell 用補完
  NeoBundle 'ujihisa/neco-ghc'
" }}}

" Seearching/Moving {{{
  " マーク位置表示
  NeoBundle "ShowMarks"
  
  " 「%」による対応括弧へのカーソル移動機能を拡張
  runtime macros/matchit.vim
" }}}

" Programming {{{
  " QuickRun : 編集中のファイルを簡単に実行できるプラギン
  NeoBundle "thinca/vim-quickrun"

  " Quckrun フック集
  NeoBundle "osyo-manga/shabadou.vim"

  " マニュアル参照
  NeoBundle 'thinca/vim-ref'
  
  " Hoogle 参照
  NeoBundle 'ujihisa/ref-hoogle'

  " SQLUtilities : SQL整形、生成ユーティリティ
  NeoBundle 'SQLUtilities'

  " Tagbar
  NeoBundle 'majutsushi/tagbar'
  
  " Tagbar PHP
  NeoBundle 'vim-scripts/tagbar-phpctags', {
    \   'build' : {
    \     'others' : 'chmod +x bin/phpctags',
    \   },
    \ }

  " Tagbar Haskell
  NeoBundle 'bitc/lushtags', {
    \   'build' : {
    \     'others' : 'cabal configure && cabal build && cabal install',
    \   },
    \ }

  " GHC を用いた Haskell の型表示
  NeoBundle 'eagletmt/ghcmod-vim'
" }}}

" Syntax {{{
  " CoffeeScript の syntax + 自動compile
  NeoBundle 'kchmck/vim-coffee-script'

  " JavaScript テンプレート ejs 用
  NeoBundle 'jeyb/vim-jst'

  " JavaScript シンタックスハイライト
  NeoBundle 'JavaScript-syntax'

  " Scala
  NeoBundle 'derekwyatt/vim-scala'

  " Haskell
  NeoBundle 'dag/vim2hs'

  " Hakell HTML テンプレート
  NeoBundle 'pbrisbin/html-template-syntax'

  " シンタックスチェッカ
  " NeoBundle 'scrooloose/syntastic'
  NeoBundle "osyo-manga/vim-watchdogs"

  " Quckfix を見てエラー部分をハイライト
  NeoBundle "jceb/vim-hier"
" }}}

" Encording {{{
  NeoBundle 'banyan/recognize_charcode.vim'
" }}}

" Utility {{{
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
" }}}

" ColorSchema {{{
  " かっこいいカラースキーム
  NeoBundle 'altercation/vim-colors-solarized'
" }}}

" Unit {{{
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'tsukkee/unite-help'
  NeoBundle 'h1mesuke/unite-outline'
  NeoBundle 'thinca/vim-unite-history'
  NeoBundle 'tsukkee/unite-tag'

  " Haskell のインポート
  NeoBundle 'ujihisa/unite-haskellimport'
" }}}


" ファイルタイプ判定をon
filetype plugin indent on

" 各プラグインのインストール状態チェック
NeoBundleCheck

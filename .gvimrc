"-----------------------------------------------------------------------------
" □ ウィンドウ表示関連 {{{
"-----------------------------------------------------------------------------
" ウィンドウサイズ
set lines=40 columns=160

" Mac版ならほのかに半透明
if has('gui_macvim')
  set transparency=5
endif

set guioptions-=m " メニューバー非表示

set guioptions-=T " ツールバー非表示

set guioptions-=r " 右スクロールバー非表示

set guioptions-=R

set guioptions-=l " 左スクロールバー非表示

set guioptions-=L
"}}}
"-----------------------------------------------------------------------------
" □ 表示関連 {{{
"-----------------------------------------------------------------------------
" カラースキーム設定
" ※.vimrcでも指定しているがここでも指定しないとちゃんと反映ならない
colorscheme hybrid

" カーソル行はアンダーラインを引く
highlight clear CursorLine
highlight CursorLine gui=underline

" フォント
if has('win32')
  set guifont=Ricty_Diminished_for_Powerline:h16
else
  set guifont=Ricty_Regular_for_Powerline:h16
endif
set linespace=2
"}}}
"-----------------------------------------------------------------------------
" □ IME関連 {{{
"-----------------------------------------------------------------------------
if has('multi_byte_ime') || has('xim') || has('gui_macvim')
  " IME の ON/OFF でキャレットの色を変える
  highlight Cursor guifg=NONE guibg=White
  highlight CursorIM guifg=NONE guibg=DarkRed
endif
"}}}
"-----------------------------------------------------------------------------

" vim:set foldmethod=marker:



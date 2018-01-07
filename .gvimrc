"-------------------------------------------------------------------------------------------------
" □ウィンドウ関連 {{{
"-------------------------------------------------------------------------------------------------
" ウィンドウサイズの設定
set lines=40 columns=160

" Kaoriya 版ならばほのかに半透明にする
if has('kaoriya')
  set transparency=5

  if has('win32') || has('win64')
    autocmd GUIEnter * set transparency=240
  endif
endif

" メニューバー非表示
set guioptions-=m
" ツールバー非表示
set guioptions-=T
" 右スクロールバー非表示
set guioptions-=r
set guioptions-=R
" 左スクロールバー非表示
set guioptions-=l
set guioptions-=L
" }}}
"-------------------------------------------------------------------------------------------------
" □表示関連 {{{
"-------------------------------------------------------------------------------------------------
" フォントの設定
set guifont=Myrica\ Monospace:h16

" カラースキームの設定
set background=dark
colorscheme hybrid

" カレント行ハイライトON
set cursorline
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE
" }}}
"-------------------------------------------------------------------------------------------------
" vim:set foldmethod=marker:

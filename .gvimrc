"-------------------------------------------------------------------------------------------------
" □ ウィンドウ関連 {{{
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
" □ 表示関連 {{{
"-------------------------------------------------------------------------------------------------
" フォントの設定
set guifont=Myrica\ Monospace:h14
set linespace=2

if has('win32') || has('win64')
  " Direct X を使用する
  set rop=type:directx,geom:1,renmode:5
endif

" カラースキームの設定
set background=dark
colorscheme hybrid

" カレント行ハイライトON
set cursorline
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE

" カーソルが一番上や下に移動した時のビープ音を消す＆画面フラッシュも消す
set vb t_vb=
" }}}
"-------------------------------------------------------------------------------------------------
" vim:set foldmethod=marker:

" ウィンドウサイズの設定
set lines=40 columns=160

" Kaoriya 版ならばほのかに半透明にする
if has('kaoriya')
  set transparency=5
endif

" フォントの設定
set guifont=Myrica\ Monospace:h16

" カラースキームの設定
set background=dark
colorscheme hybrid

" カレント行ハイライトON
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE

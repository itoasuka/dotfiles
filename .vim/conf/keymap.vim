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

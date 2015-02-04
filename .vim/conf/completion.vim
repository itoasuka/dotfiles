set wildmenu            " コマンド補完を強化
set wildchar=<tab>      " コマンド補完を開始するキー
set wildmode=list:full  " リスト表示、最長マッチ
set history=1000        " コマンド・検索パターンの履歴数
set complete+=k         " 補完に辞書ファイル追加


"-------------------------------------------------------------------------------
" neocomplete
"-------------------------------------------------------------------------------
" AutoComplPop は使わない
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" 補完候補の先頭を選択状態にする
" let g:neocomplete#enable_auto_select = 1
" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 20

" Define dictionary.
let g:neocomplete#souce#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME . '/.vimshell_hist',
    \ 'php' : $HOME . '/dict/php.dict'
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

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

" オムニ補完の有効化
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" 重いオムニ補完の有効化
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


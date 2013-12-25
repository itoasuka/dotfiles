"-------------------------------------------------------------------------------
" Haskell
"-------------------------------------------------------------------------------
" このバッファに対してまだ実行されていない場合のみ処理を実行する
" if exists("b:did_ftplugin")
    " finish
" endif
" let b:did_ftplugin = 1

" ファイル保存時にソースチェック
augroup ghcmodcheck
  autocmd! BufWritePost <buffer> GhcModCheckAsync
augroup END


"" Keymap
nnoremap <buffer> <Space>l :<C-u>UniteWithCursorWord haskellimport<Cr>
nnoremap <buffer> <LocalLeader>t :GhcModType<Cr>


"-------------------------------------------------------------------------------
" Project
"-------------------------------------------------------------------------------
" source ~/.vim/plugin/project.vim

" ファイルが選択されたらプロジェクトウィンドウを閉じる
let g:proj_flags = "imstc"
" <Leader>P でプロジェクトをトグルで開閉する
nmap <silent> <Leader>P <Plug>ToggleProject
" <Leader>p でデフォルトのプロジェクトを開く
nmap <silent> <Leader>p :Project<CR>

" カレントディレクトリにプロジェクト管理ファイルがあったら読み込む
" if getcwd() != $HOME
    " if filereadable(getcwd(). '/.vimprojects')
        " Project .vimprojects
    " endif
" endif

"-------------------------------------------------------------------------------
" eskk
"-------------------------------------------------------------------------------
let g:eskk#directory = "~/.eskk"
let g:eskk#dictionary = { 'path': "~/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp', }
let g:eskk#enable_completion = 1
"-------------------------------------------------------------------------------
" The NERD Commenter
"-------------------------------------------------------------------------------
" コメントした後に挿入するスペースの数
let NERDSpaceDelims = 1
" キーマップの変更。<Leader>\でコメント化と解除を行う。
" コメントされていれば、コメントを外し、コメントされてなければコメント化する。
nmap <Leader>\ <Plug>NERDCommenterToggle
vmap <Leader>\ <Plug>NERDCommenterToggle
""未対応ファイルタイプのエラーメッセージを表示しない
let NERDShutUp=1

"-------------------------------------------------------------------------------
" indent_guides
"-------------------------------------------------------------------------------
" インデントの深さに色を付ける
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0

augroup indentguides
  autocmd!
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
augroup END

"-------------------------------------------------------------------------------
" tagbar
"-------------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>

"-------------------------------------------------------------------------------
" quckrun
"-------------------------------------------------------------------------------
" Markdown プレビュー用（Mac 限定）
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'outputter' : 'null',
      \ 'command'   : 'open',
      \ 'cmdopt'    : '-a',
      \ 'args'      : 'Marked',
      \ 'exec'      : '%c %o %a %s',
      \ }

"-------------------------------------------------------------------------------
" Markdown
"-------------------------------------------------------------------------------
" 拡張子 md も Markdown として扱う
autocmd BufRead,BufNewFile *.md set filetype=markdown

"-------------------------------------------------------------------------------
" Project
"-------------------------------------------------------------------------------
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

"-------------------------------------------------------------------------------
" Pukiwiki
"-------------------------------------------------------------------------------
" PukiWiki のサイト情報 "
let g:pukiwiki_config = {
\   "STL" : {
\       "url" : "http://ittan.zoo.microbridge.jp/pukiwiki/",
\       "top" : "FrontPage",
\   },
\}

"-------------------------------------------------------------------------------
" hier
"-------------------------------------------------------------------------------
" ハイライトの設定
execute "highlight ucurl_my gui=undercurl guisp=Red"
let g:hier_highlight_group_qf = "ucurl_my"

" ハイライト箇所を更新
nnoremap <Space>hiu :HierUpdate<CR>

" ハイライトを削除
nnoremap <Space>hic :HierClear<CR>

let g:hier_enabled = 1

"-------------------------------------------------------------------------------
" VimFiler
"-------------------------------------------------------------------------------
" VimFiler をデフォルトのファイラにする
let g:vimfiler_as_default_explorer = 1

" ファイルを開くときは新たしいタブページで
let g:vimfiler_edit_action = 'tabopen'


"-------------------------------------------------------------------------------
" Syntastics
"-------------------------------------------------------------------------------
" ファイルを開いた時にシンタックスチェックをしない
let g:syntastic_check_on_open = 0
" ファイルを保存した時にシンタックスチェックをする
let g:syntastic_check_on_save = 1
" TypeScript のシンタックスチェッカを指定
let g:syntastic_typescript_checkers = ['tsc']
" シンタックスチェッカを利用するファイルタイプを指定
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['javascript', 'typescript'],
      \ 'passive_filetypes': []
      \ }
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

"-------------------------------------------------------------------------------
" Eclim
"-------------------------------------------------------------------------------
let s:bundle = neobundle#get("eclim")
function! s:bundle.hooks.on_source(bundle)
  let g:EclimCompletionMethod = 'omnifunc'
endfunction
unlet s:bundle

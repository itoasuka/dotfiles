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
" JavaScript のシンタックスチェッカを指定
let g:syntastic_javascript_checkers = ['eslint']
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

"-------------------------------------------------------------------------------
" NeoSnippet
"-------------------------------------------------------------------------------
" Plugin key-mappings.  " <C-k>でsnippetの展開
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" 自分用 snippet ファイルの場所
let s:my_snippet = '~/.vim/snippet/'
let g:neosnippet#snippets_directory = s:my_snippet

"-------------------------------------------------------------------------------
" Unite
"-------------------------------------------------------------------------------
"prefix keyの設定
nmap <Space> [unite]

"スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>

"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

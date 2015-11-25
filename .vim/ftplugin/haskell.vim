" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:ycm_semantic_triggers = {'haskell' : ['.']}
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

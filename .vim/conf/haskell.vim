" ghcmod.vimをcabal-dev環境下で使うための設定関数
function! g:add_cabal_dev_conf(cabal_dev_conf)
  let l:kw = '%:p:h'
  let l:path = expand(l:kw)
  while l:path != ''
    if isdirectory(l:path . a:cabal_dev_conf)
      if !exists('b:ghcmod_ghc_options')
        let b:ghcmod_ghc_options = []
      endif
      call add(b:ghcmod_ghc_options, '-package-conf=' . l:path . a:cabal_dev_conf)
      break
    else
      if l:path == '/'
        break
      else
        let l:kw = l:kw . ':h'
        let l:path = expand(l:kw)
      endif
    endif
  endwhile
endfunction


let plugins = dein#load_cache_raw(['/Users/asuka/dotfiles/.vim/init.vim'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_base_path = '/Users/asuka/.vim/dein'
let g:dein#_runtime_path = '/Users/asuka/.vim/dein/.dein'
let &runtimepath = '/Users/asuka/.vim/dein/repos/github.com/tpope/vim-fugitive,/Users/asuka/.vim/dein/repos/github.com/airblade/vim-gitgutter,/Users/asuka/.vim/dein/.dein,/Users/asuka/.config/nvim,/etc/xdg/nvim,/Users/asuka/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/HEAD/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/asuka/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/asuka/.config/nvim/after,/Users/asuka/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/asuka/.vim/dein/.dein/after'
filetype off
silent! command -complete=customlist,dein#autoload#_dummy_complete -bang -bar -range -nargs=* Project call dein#autoload#_on_cmd('Project', 'vim-project', <q-args>,  expand('<bang>'), expand('<line1>'), expand('<line2>'))
autocmd dein-events InsertEnter * call dein#autoload#_on_event("InsertEnter", ['neocomplete.vim', 'deoplete.nvim'])

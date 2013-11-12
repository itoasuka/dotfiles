" カラー設定
syntax enable
set background=dark
colorscheme solarized

" ウィンドウサイズ
set lines=50 columns=180

" フォント
set guifont=Ricty:h14

" IME の設定
if has('multi_byte_ime') || has('xim') || has('gui_macvim')
    " ノーマルモードに戻った気は IME を OFF にする
    inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

    " IME の ON/OFF でキャレットの色を変える
    highlight Cursor guifg=NONE guibg=White
    highlight CursorIM guifg=NONE guibg=DarkRed
endif


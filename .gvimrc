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
    set noimdisable
    set iminsert=0 imsearch=0
    set noimcmdline
    " ノーマルモードに戻ったときは IME を OFF にする
    inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

    " IME の ON/OFF でキャレットの色を変える
    highlight Cursor guifg=NONE guibg=White
    highlight CursorIM guifg=NONE guibg=DarkRed
endif

" インデントの深さに応じて自動的に色を付ける
let g:indent_guides_auto_colors = 1

if has('gui_macvim')
    set transparency=5
endif

set guioptions-=r	" 右スクロールバー非表示

set guioptions-=R

set guioptions-=l	" 左スクロールバー非表示

set guioptions-=L

highlight CursorLine gui=underline

set encoding=utf-8

scriptencoding utf-8

" プラグイン等の読み込み
source ~/.vim/conf/bundle.vim

" ステータスライン関連
source ~/.vim/conf/statusline.vim

" 基本設定
source ~/.vim/conf/basic.vim

" インデント関連
source ~/.vim/conf/indent.vim

" 表示関連
source ~/.vim/conf/apperance.vim

" 補完関連
if has('lua') && (v:version > 703 || v:version == 703 && has('patch885'))
  source ~/.vim/conf/completion.vim
endif

" 色関連
source ~/.vim/conf/color.vim

" エンコーディング関連
source ~/.vim/conf/encoding.vim

" タグ関連
source ~/.vim/conf/tags.vim

" 検索関連
source ~/.vim/conf/search.vim

" キーマップ関連
source ~/.vim/conf/keymap.vim

" 編集関連
source ~/.vim/conf/editing.vim

" プラグイン関連
source ~/.vim/conf/plugin_setting.vim


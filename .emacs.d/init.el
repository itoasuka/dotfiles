;; MELPAの設定
(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize))

;; パッケージ情報の更新
(package-refresh-contents)

;; インストールするパッケージ
(defvar my/favorite-packages
  '(
    ;;;; Theme
    color-theme-solarized

    ;;;; for auto-complete
    auto-complete

    ;;;; helm
    helm

    ;;;; evil
    evil

    ;;;; Scala
    ensime scala-mode2

    ;;;; Other
    web-mode

    recentf-ext
    ))

;; my/favorite-packagesからインストールしていないパッケージをインストール
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))

;;----------------------------------------------------------------------------
;; □ 最近使ったファイルのパスの保存
;;----------------------------------------------------------------------------
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-max-saved-items 1000)            ;; recentf に保存するファイルの数
(setq recentf-exclude '(".recentf"))           ;; .recentf自体は含まない
(setq recentf-auto-cleanup 10)                 ;; 保存する内容を整理
(run-with-idle-timer 30 t 'recentf-save-list)  ;; 30秒ごとに .recentf を保存
(require 'recentf-ext)

;;----------------------------------------------------------------------------
;; □ システムの判別
;;----------------------------------------------------------------------------
;; system-type predicates
;; from http://d.hatena.ne.jp/tomoya/20090807/1249601308
(setq darwin-p   (eq system-type 'darwin)
      linux-p    (eq system-type 'gnu/linux)
      carbon-p   (eq system-type 'mac)
      meadow-p   (featurep 'meadow))

;;----------------------------------------------------------------------------
;; □ クリップボード連係の設定
;;----------------------------------------------------------------------------
; Emacs と Mac のクリップボード共有
; from http://hakurei-shain.blogspot.com/2010/05/mac.html
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(if (or darwin-p carbon-p)
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))    

;;----------------------------------------------------------------------------
;; □ 文字コードの設定
;;----------------------------------------------------------------------------
;; ファイルシステムの文字コードの設定
(cond
 ((or darwin-p carbon-p)
  ;; Mac OS X の HFS+ ファイルフォーマットではファイル名は NFD (の様な物)で扱うため以下の設定をする必要がある
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
 (or (eq system-type 'cygwin) (eq system-type 'windows-nt)
     (setq file-name-coding-system 'utf-8)
     (setq locale-coding-system 'utf-8)
     ;; もしコマンドプロンプトを利用するなら sjis にする
     ;; (setq file-name-coding-system 'sjis)
     ;; (setq locale-coding-system 'sjis)
     ;; 古い Cygwin だと EUC-JP にする
     ;; (setq file-name-coding-system 'euc-jp)
     ;; (setq locale-coding-system 'euc-jp)
     )
 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)))

;;----------------------------------------------------------------------------
;; □ 基本設定
;;----------------------------------------------------------------------------
;; 常に行番号を表示する
(global-linum-mode t)
(if window-system (setq linum-format "%4d") (setq linum-format "%4d|"))

;; カーソル行をハイライトする
(global-hl-line-mode t)

;;----------------------------------------------------------------------------
;; □ 色の設定
;;----------------------------------------------------------------------------
;; カラーテーマ
(load-theme 'solarized t)
(set-terminal-parameter nil 'background-mode 'dark)
(set-frame-parameter nil 'background-mode 'dark)
(setq solarized-termcolors 256)
(enable-theme 'solarized)
;(add-to-list 'load-path "~/.emacs.d/themes")
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(load-theme 'tomorrow-night-eighties t)

;;----------------------------------------------------------------------------
;; □ IME 関連の設定
;;----------------------------------------------------------------------------
;; Solarizedのカーソル色
(setq solarized-dark-cursor-color "#839496")

(add-hook 'mw32-ime-on-hook
	  (function (lambda () (set-cursor-color "magenta"))))
(add-hook 'mw32-ime-off-hook
	  (function (lambda () (set-cursor-color solarized-dark-cursor-color))))

(when (fboundp 'mac-set-input-method-parameter)
  (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `cursor-color "magenta")
  (mac-set-input-method-parameter "com.apple.keylayout.US" `cursor-color solarized-dark-cursor-color))

;; Emacs Mac Port 用設定
;; ミニバッファで入力する際に自動的にASCIIにする
(when (fboundp 'mac-auto-ascii-mode)
  (mac-auto-ascii-mode 1))
;; カーソルの色を変える
(when (fboundp 'mac-input-source)
  (defun my-mac-selected-keyboard-input-source-chage-function ()
    "英語のときはカーソルの色をdim grayに、日本語のときはbrownにします."
    (let ((mac-input-source (mac-input-source)))
      (set-cursor-color
       (if (string-match "\\.Roman$" mac-input-source)
	   solarized-dark-cursor-color "magenta"))))
  (add-hook 'mac-selected-keyboard-input-source-change-hook
	    'my-mac-selected-keyboard-input-source-chage-function))
;;----------------------------------------------------------------------------
;; □ shell関連の設定
;;----------------------------------------------------------------------------
;; Shellのパス設定を持ってくる
(exec-path-from-shell-initialize)

;; eshellでエスケープシーケンスをまともに表示させる
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
			      eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

;;----------------------------------------------------------------------------
;; □ ウィンドウ関連の設定
;;----------------------------------------------------------------------------
;; メニューバーを非表示
(menu-bar-mode 0)
;; ツールバーを非表示
(tool-bar-mode 0)

;; 起動時のフレーム設定
(if window-system (progn
		    (setq initial-frame-alist
			  (append (list
				   ;; 表示位置
				   '(top . 0)
				   '(left . 0)
				   ;; サイズ
				   '(width . 160)  ;横
				   '(height . 40)) ;縦
				  initial-frame-alist))
		    (setq default-frame-alist initial-frame-alist)
))

;; スタートアップページを表示しない
(setq inhibit-startup-message t)

;; Ricty フォントの利用
(if window-system (progn
		    (create-fontset-from-ascii-font "Ricty-16:weight=normal:slant=normal" nil "ricty")
		    (set-fontset-font "fontset-ricty"
				      'unicode
				      (font-spec :family "Ricty" :size 16)
				      nil
				      'append)
		    (add-to-list 'default-frame-alist '(font . "fontset-ricty"))
))

;;----------------------------------------------------------------------------
;; □ auto-completeの設定
;;----------------------------------------------------------------------------
(when (require 'auto-complete-config nil t)
  (ac-config-default))

;;----------------------------------------------------------------------------
;; □ Evilの設定
;;----------------------------------------------------------------------------
(require 'evil)
(evil-mode 1)
;; unimpaired風操作
(define-key evil-normal-state-map "]b" 'next-buffer)
(define-key evil-normal-state-map "[b" 'previous-buffer)
;; unite風操作
(define-key evil-normal-state-map ",um" 'helm-recentf)

;;----------------------------------------------------------------------------
;; □ JavaSriptの設定
;;----------------------------------------------------------------------------
;; JavaScriptの設定
(add-hook 'js-mode-hook
          (function
           (lambda ()
             (setq indent-tabs-mode nil)
             )))
(setq js-indent-level 2)

;; emmet
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップモードで自動的に emmet-mode をたちあげる
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces
(setq emmet-move-cursor-between-quotes t) ;; 最初のクオートの中にカーソルをぶちこむ

;;----------------------------------------------------------------------------
;; □ web-modeの設定
;;----------------------------------------------------------------------------
;; web-modeの設定
(require 'web-mode)
;; .jsx ファイルを web-mode の対象とする。
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;; インデントは2
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-attr-indent-offset nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-sql-indent-offset 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2))
(add-hook 'web-mode-hook 'my-web-mode-hook)

;;----------------------------------------------------------------------------
;; □ Scalaの設定
;;----------------------------------------------------------------------------
(require 'scala-mode2)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;;(setq ensime-completion-style 'auto-complete)
(defun my-ac-scala-mode ()
  (add-to-list 'ac-sources 'ac-source-dictionary)
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  (add-to-list 'ac-sources 'ac-source-words-in-buffer)
  (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffers)
  (setq ac-sources (reverse ac-sources)) ;;;追記2
  )

(add-hook 'ensime-mode-hook 'my-ac-scala-mode)

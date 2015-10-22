;; MELPAの設定
(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize))

;;----------------------------------------------------------------------------
;; □ 文字コードの設定
;;----------------------------------------------------------------------------
;; ファイルシステムの文字コードの設定
(cond
 ((or (eq window-system 'mac) (eq window-system 'ns))
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

;;----------------------------------------------------------------------------
;; □ 色の設定
;;----------------------------------------------------------------------------
;; カラーテーマ
;(load-theme 'solarized-dark t)
(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night-eighties t)


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

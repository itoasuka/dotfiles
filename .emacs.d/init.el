(require 'package)
(add-to-list 'package-archives '("melpath" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8)

(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップモード時に自動的に開始する
(add-hook 'css-mode-hook  'emmet-mode) ;; CSS のときも自動で開始する

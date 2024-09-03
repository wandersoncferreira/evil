;;; custom/shell/config.el -*- lexical-binding: t; -*-

(use-package! chatgpt-shell
 :ensure t
 :config
 (setq chatgpt-shell-openai-key
       (plist-get (car (auth-source-search :max 1 :host "openai.com")) :secret)))

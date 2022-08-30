;;; custom/denote/config.el -*- lexical-binding: t; -*-

(use-package! denote
  :init
  (setq denote-directory (expand-file-name "~/org/denote")
        denote-file-type nil
        denote-known-keywords
        '("emacs"
          "programming lang"
          "apl"
          "clojure"
          "haskell"
          "advices"))
  :config
  (add-hook 'dired-mode-hook #'denote-dired-mode))

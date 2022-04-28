;;; $DOOMDIR/preferences/+elisp.el -*- lexical-binding: t; -*-

;; remove highlighting of the parens...
(after! elisp-mode
  (remove-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

;; fix parens handling in Evil
(add-hook! emacs-lisp-mode-hook #'(evil-cleverparens-mode evil-smartparens-mode))

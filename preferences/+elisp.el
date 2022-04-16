;;; ../code/evil/preferences/+elisp.el -*- lexical-binding: t; -*-

;; remove highlighting of the parens...
(after! elisp-mode
  (remove-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

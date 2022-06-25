;;; $DOOMDIR/preferences/+elisp.el -*- lexical-binding: t; -*-

;; remove highlighting of the parens...
(after! elisp-mode
  (remove-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

;; handling parens correctly
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (evil-cleverparens-mode)
            (evil-smartparens-mode)))

;; eval buffer
(map! :mode emacs-lisp-mode
      :localleader
      "eb" #'eval-buffer)

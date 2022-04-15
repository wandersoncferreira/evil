;;; ../code/evil/+parens.el -*- lexical-binding: t; -*-

(use-package! smartparens
  :init
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
  :config
  ;; fix bugs with smartparens and unbalanced pairs
  (dolist (brace '("(" "{" "[" "'" "\""))
    (sp-pair brace nil :unless nil))
  :hook ((clojure-mode . smartparens-strict-mode)
         (emacs-lisp-mode . smartparens-strict-mode)))

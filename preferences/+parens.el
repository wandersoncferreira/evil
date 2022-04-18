;;; ../code/evil/preferences/+parens.el -*- lexical-binding: t; -*-

(use-package! smartparens
  :config
  ;; fix bugs with smartparens and unbalanced pairs
  (dolist (brace '("(" "{" "[" "'" "\""))
    (sp-pair brace nil :unless nil))
  :hook ((clojure-mode . smartparens-strict-mode)
         (emacs-lisp-mode . smartparens-strict-mode)))

(map! :leader
      (:prefix ("l" . "lisp")
       :desc "slurp" "l" #'sp-forward-slurp-sexp
       :desc "barf" "b" #'sp-forward-barf-sexp
       :desc "splice" "k" #'sp-splice-sexp-killing-backward
       :desc "transpose" "t" #'sp-transpose-sexp))

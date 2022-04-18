;;; ../code/evil/preferences/+parens.el -*- lexical-binding: t; -*-

(use-package! smartparens
  :init
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
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
       :desc "raise" "r" #'sp-raise-sexp
       :desc "transpose" "t" #'sp-transpose-sexp))

;; disable evil-smartparens overwriting of s/S keys
(map! :map (evil-smartparens-mode-map)
      :n "s" nil
      :n "S" nil)

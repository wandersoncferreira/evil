;;; ../code/evil/preferences/+bindings.el -*- lexical-binding: t; -*-

;; general remapping
(map! :leader
      "fj" #'dired-jump
      "y" #'consult-yank-from-kill-ring
      "pt" #'projectile-toggle-between-implementation-and-test)

;; keybindings on parens
(map! :leader
      (:prefix ("l" . "lisp")
       :desc "slurp" "l" #'sp-forward-slurp-sexp
       :desc "barf" "b" #'sp-forward-barf-sexp
       :desc "splice backward" "k" #'sp-splice-sexp-killing-backward
       :desc "raise" "r" #'sp-raise-sexp
       :desc "transpose" "t" #'sp-transpose-sexp)
      :i "M-l" #'sp-forward-slurp-sexp
      :i "M-h" #'sp-forward-barf-sexp)

;; disable evil-smartparens overwriting of s/S keys
(map! :map (evil-smartparens-mode-map)
      :n "s" nil
      :n "S" nil)

;; clojure keybindings
(map! (:localleader
       (:map (clojure-mode-map)
        (:prefix ("e" . "eval")
         "v" #'cider-eval-sexp-at-point
         ";" #'cider-eval-defun-to-comment))))

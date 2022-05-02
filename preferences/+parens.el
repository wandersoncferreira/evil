;;; $DOOMDIR/preferences/+parens.el -*- lexical-binding: t; -*-

(after! smartparens
  (add-hook! (clojure-mode emacs-lisp-mode) #'smartparens-strict-mode))

(map! :leader
      (:prefix ("l" . "lisp")
       :desc "slurp" "l" #'sp-forward-slurp-sexp
       :desc "barf" "b" #'sp-forward-barf-sexp
       :desc "splice" "k" #'sp-splice-sexp-killing-backward
       :desc "transpose" "t" #'sp-transpose-sexp))

(defun bk/improve-last-parens ()
  (interactive)
  (evil-normal-state)
  (evil-append-line 1))

(map! :i "C-j" #'bk/improve-last-parens
      :i "C-l" #'sp-forward-sexp)

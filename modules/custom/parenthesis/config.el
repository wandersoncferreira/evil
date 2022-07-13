;;; custom/parenthesis/config.el -*- lexical-binding: t; -*-

(use-package! evil-cleverparens
  :init
  (setq evil-cleverparens-complete-parens-in-yanked-region t
        evil-cleverparens-use-additional-movement-keys nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-s-and-S nil
        evil-cleverparens-move-skip-delimiters nil
        evil-cleverparens-use-regular-insert t
        evil-cleverparens-indent-afterwards nil))

;; enable parenthesis handler in Clojure mode
(after! smartparens
  (add-hook!
    (clojure-mode emacs-lisp-mode)
    #'smartparens-strict-mode))

;; enable parenthesis handler in Emacs Lisp mode
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (evil-cleverparens-mode)
            (evil-smartparens-mode)))

;; remove highlighting of the parens...
(after! elisp-mode
  (remove-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

;; make leader + l to handle parenthesis
(map! :leader
      (:prefix ("l" . "lisp")
       :desc "slurp" "l" #'sp-forward-slurp-sexp
       :desc "barf" "b" #'sp-forward-barf-sexp
       :desc "splice" "k" #'sp-splice-sexp-killing-backward
       :desc "transpose" "t" #'sp-transpose-sexp))

(map! :i "C-j" #'bk/improve-last-parens
      :i "C-l" #'sp-forward-sexp)

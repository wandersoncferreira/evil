;;; custom/parenthesis/config.el -*- lexical-binding: t; -*-

(use-package! evil-cleverparens
  :config
  (setq evil-cleverparens-move-skip-delimiters nil
        evil-cleverparens-use-additional-movement-keys nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-regular-insert t)
  ;; (setq evil-cleverparens-complete-parens-in-yanked-region t
  ;;       evil-cleverparens-use-s-and-S nil
  ;;       evil-cleverparens-indent-afterwards nil)
  )

(after! smartparens
  (add-hook!
    (emacs-lisp-mode)
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

;; disable evil-cleverparens "clever"-append that tries to include a space
;; before some identifiers when we switch to insert mode
;; idk, it annoys me.
(map! :map evil-cleverparens-mode-map
      :n "i" nil
      :n "a" nil)

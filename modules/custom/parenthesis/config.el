;;; custom/parenthesis/config.el -*- lexical-binding: t; -*-

(use-package! evil-cleverparens
  :init
  (setq evil-cleverparens-move-skip-delimiters nil
        evil-cleverparens-use-additional-movement-keys nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-regular-insert t)
  ;; (setq evil-cleverparens-complete-parens-in-yanked-region t
  ;;       evil-cleverparens-use-s-and-S nil
  ;;       evil-cleverparens-indent-afterwards nil)
  :config
  ;; clojure setup
  (after! clojure-mode
    (add-hook 'clojure-mode-hook
              (lambda ()
                (evil-cleverparens-mode))))
  ;; emacs setup
  (after! elisp-mode
    (add-hook 'emacs-lisp-mode-hook
              (lambda ()
                (evil-cleverparens-mode)))))

(use-package! evil-smartparens
  :after evil-cleverparens
  :config
  ;; clojure-setup
  (after! clojure-mode
    (add-hook 'clojure-mode-hook
              (lambda ()
                (evil-smartparens-mode))))
  ;; emacs setup
  (after! elisp-mode
    (add-hook 'emacs-lisp-mode-hook
              (lambda ()
                (evil-smartparens-mode)))))

(use-package! smartparens
  :config
  ;; Doom's default module skips pairs if one is typed at the beggining of word
  (dolist (brace '("(" "{" "["))
    (sp-pair brace nil
             :post-handlers '(("||\n[i]" "RET") ("| " "SPC"))
             :unless '(sp-point-before-same-p))
    (sp-local-pair sp-lisp-modes "(" ")"
                   :wrap ")"
                   :unless '(:rem sp-point-before-same-p)))

  (after! elisp-mode
    (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode))
  (after! clojure-mode
    (add-hook 'clojure-mode-hook #'smartparens-strict-mode))

  (after! haskell-mode
    (add-hook 'haskell-mode-hook #'smartparens-strict-mode)))

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

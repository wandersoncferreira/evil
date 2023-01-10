;;; custom/parenthesis/config.el -*- lexical-binding: t; -*-

(defvar bk-lisp-modes
  '(emacs-lisp-mode
    elisp-mode
    clojure-mode
    cider-repl-mode))

(defun bk/str-mode->symbol-hook (name)
  (-> (symbol-name name)
      (concat "-hook")
      (intern)))

(defun bk/add-hooks (modes func)
  (dolist (mode modes)
    (add-hook (bk/str-mode->symbol-hook mode) func)))

(defun bk/remove-hooks (modes func)
  (dolist (mode modes)
    (add-hook 'after-init-hook
              (lambda ()
                (remove-hook (bk/str-mode->symbol-hook mode) func)))))

(use-package! evil-cleverparens
  :init
  (setq evil-cleverparens-move-skip-delimiters nil
        evil-cleverparens-use-additional-movement-keys nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-regular-insert t)
  :config
  (bk/add-hooks bk-lisp-modes #'evil-cleverparens-mode))

(use-package! evil-smartparens
  :after evil-cleverparens
  :config
  (bk/add-hooks bk-lisp-modes #'evil-smartparens-mode))

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

  (bk/add-hooks bk-lisp-modes #'smartparens-strict-mode))

;; remove highlighting of the parens...
(bk/remove-hooks bk-lisp-modes #'rainbow-delimiters-mode)

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

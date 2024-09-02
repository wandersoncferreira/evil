;;; custom/completions/config.el -*- lexical-binding: t; -*-

;; tab key is very useful in insert mode to fix identation or completion imho
(setq tab-always-indent 'complete)

;;; consult
;; disable the default preview when switching buffers
(after! consult
  (setq consult-preview-key "M-."))

;;; embark
;; do not ask for confirmation to delete a bookmark
(after! embark
  (setf embark-pre-action-hooks
        (assoc-delete-all
         'bookmark-delete
         embark-pre-action-hooks)))

(use-package! vertico
  :config
  ;; restore some vim balance
  ;; if you want to type  [ or ] in the minibuffer use C-q [ or ]
  (map! :n "[I" #'+vertico/search-symbol-at-point
        :map vertico-map
        "]" #'vertico-next-group
        "[" #'vertico-previous-group))

;;; fix to make `company-tng' work with `company-box'
(after! company
  (setq company-frontends '(company-tng-frontend company-box-frontend)))

(use-package! company-box
  :defer t
  :config
  (setq-hook! 'prog-mode-hook
    company-box-frame-top-margin 20)
  (setq-hook! 'text-mode-hook
    company-box-frame-top-margin 75)
  (set-face-attribute 'child-frame-border nil :background "#ffffff")
  (setq company-box-doc-frame-parameters '((left-fringe . 10) (right-fringe . 10))))

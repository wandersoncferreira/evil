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

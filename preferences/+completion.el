;;; $DOOMDIR/preferences/+completion.el -*- lexical-binding: t; -*-

;;; consult
;; disable the default preview when switching buffers
(after! consult
  (setq consult-preview-key (kbd "M-.")))

;;; embark
;; do not ask for confirmation to delete a bookmark
(after! embark
  (setf embark-pre-action-hooks
        (assoc-delete-all
         'bookmark-delete
         embark-pre-action-hooks)))

;;; vertico
;; restore some vim balance
;; if you want to type  [ or ] in the minibuffer use C-q [ or ]
(map! :n "[I" #'+vertico/search-symbol-at-point
      :map vertico-map
      "]" #'vertico-next-group
      "[" #'vertico-previous-group)

;;; company
;; disable automatic completion
(after! company
  (setq company-idle-delay nil))
